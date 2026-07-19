
CONFIRM_MENU=(fuzzel --dmenu --lines=2 --width=30)

notify_err() {
    notify-send -u critical "Power menu" "$1" || true
}

confirm() {
    local label="$1"
    local ans
    ans=$(printf 'No\nYes\n' | "${CONFIRM_MENU[@]}" --prompt "$label? ") || return 1
    [ "$ans" = "Yes" ]
}
