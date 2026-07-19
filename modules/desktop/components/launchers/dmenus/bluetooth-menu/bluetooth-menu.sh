MENU=(fuzzel --dmenu)
SCAN_TIMEOUT="@scanTimeout@"

notify_err() {
    notify-send -u critical "Bluetooth menu" "$1" || true
}

notify_ok() {
    notify-send "Bluetooth menu" "$1" || true
}

is_powered() {
    bluetoothctl show | grep -q "Powered: yes"
}

build_menu() {
    if is_powered; then
        echo "⏻  Power off"
        echo "  Scan for devices (${SCAN_TIMEOUT}s)"
        while IFS= read -r line; do
            [ -z "$line" ] && continue
            mac=$(awk '{print $2}' <<<"$line")
            name=$(cut -d' ' -f3- <<<"$line")
            status="○"
            if bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes"; then
                status="●"
            fi
            echo "$status  $name  ($mac)"
        done < <(bluetoothctl devices)
    else
        echo "⏻  Power on"
    fi
}

device_action_menu() {
    local mac="$1" name="$2"
    local action
    if ! action=$(printf 'Connect\nDisconnect\nPair\nTrust\nUntrust\nRemove\n' | "${MENU[@]}" --prompt "$name: "); then
        return 0
    fi
    [ -z "$action" ] && return 0

    local out
    case "$action" in
        Connect)    out=$(bluetoothctl connect "$mac" 2>&1) ;;
        Disconnect) out=$(bluetoothctl disconnect "$mac" 2>&1) ;;
        Pair)       out=$(bluetoothctl pair "$mac" 2>&1) ;;
        Trust)      out=$(bluetoothctl trust "$mac" 2>&1) ;;
        Untrust)    out=$(bluetoothctl untrust "$mac" 2>&1) ;;
        Remove)     out=$(bluetoothctl remove "$mac" 2>&1) ;;
        *)          return 0 ;;
    esac

    if grep -qi "fail" <<<"$out"; then
        notify_err "$action failed for $name: $out"
    else
        notify_ok "$action: $name"
    fi
}

if ! bluetoothctl show >/dev/null 2>&1; then
    notify_err "No Bluetooth controller found"
    exit 1
fi

while true; do
    selection=$(build_menu | "${MENU[@]}" --prompt "Bluetooth: ") || exit 0
    [ -z "$selection" ] && exit 0

    case "$selection" in
        "⏻  Power on")
            out=$(bluetoothctl power on 2>&1)
            grep -qi "fail" <<<"$out" && notify_err "Power on failed: $out"
            ;;
        "⏻  Power off")
            out=$(bluetoothctl power off 2>&1)
            grep -qi "fail" <<<"$out" && notify_err "Power off failed: $out"
            ;;
        "  Scan for devices ("*)
            bluetoothctl --timeout "$SCAN_TIMEOUT" scan on >/dev/null 2>&1 || true
            ;;
        *"("*")")
            mac=$(sed -n 's/.*(\([0-9A-Fa-f:]\{17\}\)).*/\1/p' <<<"$selection")
            devname=$(sed -E 's/^[●○]  (.*)  \([0-9A-Fa-f:]{17}\)$/\1/' <<<"$selection")
            if [ -z "$mac" ]; then
                notify_err "Could not parse device address"
                continue
            fi
            device_action_menu "$mac" "$devname"
            ;;
        *)
            : # unrecognized entry, redraw menu
            ;;
    esac
done
