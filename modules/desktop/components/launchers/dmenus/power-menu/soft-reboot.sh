confirm "Soft reboot" || exit 0
if ! systemctl soft-reboot; then
    notify_err "systemctl soft-reboot failed"
    exit 1
fi
