confirm "Reboot" || exit 0
if ! systemctl reboot; then
    notify_err "systemctl reboot failed"
    exit 1
fi
