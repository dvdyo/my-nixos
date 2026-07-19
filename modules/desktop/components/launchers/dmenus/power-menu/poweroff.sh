confirm "Power off" || exit 0
if ! systemctl poweroff; then
    notify_err "systemctl poweroff failed"
    exit 1
fi
