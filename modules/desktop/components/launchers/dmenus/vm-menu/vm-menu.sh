CONNECT="qemu:///system"
APP_NAME="VM Menu"

notify() {
    # notify [urgency] "title" "body"
    local urgency="$1" title="$2" body="$3"
    notify-send -a "$APP_NAME" -u "$urgency" "$title" "$body"
}

pick_vm() {
    virsh --connect "$CONNECT" list --all --name | sed '/^$/d' | fuzzel --dmenu --prompt="VM: "
}

pick_action() {
    local vm="$1"
    printf "Start\nConnect\nShutdown\nForce off\nReboot" | fuzzel --dmenu --prompt="$vm: "
}

# Try to start a VM; if it fails because a required network is inactive,
# offer to bring the network up and retry once.
start_vm() {
    local vm="$1"
    local err net choice err2

    if err=$(virsh --connect "$CONNECT" start "$vm" 2>&1 1>/dev/null); then
        notify normal "$vm started" "Domain is now running."
        return 0
    fi

    # Common libvirt phrasing when a network exists but isn't started:
    #   error: Requested operation is not valid: network 'NAME' is not active
    net=$(printf '%s\n' "$err" | grep -oP "network '\K[^']+(?=' is not active)" || true)

    if [ -n "$net" ]; then
        choice=$(printf "Yes\nNo" | fuzzel --dmenu --prompt="Network '$net' is down. Start it? ")
        if [ "$choice" = "Yes" ]; then
            if virsh --connect "$CONNECT" net-start "$net" >/dev/null 2>&1; then
                notify normal "Network '$net' started" "Retrying VM start..."
                if err2=$(virsh --connect "$CONNECT" start "$vm" 2>&1 1>/dev/null); then
                    notify normal "$vm started" "Domain is now running."
                    return 0
                else
                    notify critical "$vm failed to start" "$err2"
                    return 1
                fi
            else
                notify critical "Failed to start network '$net'" "Check virsh net-list --all"
                return 1
            fi
        else
            notify normal "Cancelled" "Left '$net' inactive; $vm not started."
            return 1
        fi
    else
        notify critical "$vm failed to start" "$err"
        return 1
    fi
}

vm=$(pick_vm)
[ -z "$vm" ] && exit 0

action=$(pick_action "$vm")
[ -z "$action" ] && exit 0

case "$action" in
    Start)
        start_vm "$vm" || true
        ;;

    Connect)
        state=$(virsh --connect "$CONNECT" domstate "$vm" 2>/dev/null || true)
        if [ "$state" != "running" ]; then
            start_vm "$vm" || exit 1
        fi
        notify normal "$vm" "Connecting viewer..."
        virt-viewer --connect "$CONNECT" "$vm" >/tmp/vm-menu-viewer.log 2>&1 &
        ;;

    Shutdown)
        if err=$(virsh --connect "$CONNECT" shutdown "$vm" 2>&1 1>/dev/null); then
            notify normal "$vm shutting down" "ACPI shutdown requested."
        else
            notify critical "$vm shutdown failed" "$err"
        fi
        ;;

    "Force off")
        if err=$(virsh --connect "$CONNECT" destroy "$vm" 2>&1 1>/dev/null); then
            notify normal "$vm forced off" "Domain destroyed."
        else
            notify critical "$vm force off failed" "$err"
        fi
        ;;

    Reboot)
        if err=$(virsh --connect "$CONNECT" reboot "$vm" 2>&1 1>/dev/null); then
            notify normal "$vm rebooting" "ACPI reboot requested."
        else
            notify critical "$vm reboot failed" "$err"
        fi
        ;;
esac
