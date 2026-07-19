DB="@database@"
PW_MENU=(fuzzel --dmenu --lines=0 --width=70)
LIST_MENU=(fuzzel --dmenu --width=50)
MAX_ATTEMPTS="@maxAttempts@"

notify_err() {
    notify-send -u critical "Keepass menu" "$1" || true
}

cleanup() {
    unset -v password secret entries
    [ -n "${errfile:-}" ] && rm -f "$errfile"
}
trap cleanup EXIT

if [ ! -f "$DB" ]; then
    notify_err "Database not found: $DB"
    exit 1
fi

errfile=$(mktemp)
password=""
entries=""

attempt=1
while [ "$attempt" -le "$MAX_ATTEMPTS" ]; do
    if ! password=$("${PW_MENU[@]}" --password --prompt "Master password ($attempt/$MAX_ATTEMPTS): " < /dev/null); then
        exit 0
    fi
    [ -z "$password" ] && exit 0

    if entries=$(printf '%s\n' "$password" | keepassxc-cli ls -R "$DB" 2>"$errfile"); then
        break
    fi

    if [ "$attempt" -eq "$MAX_ATTEMPTS" ]; then
        notify_err "Failed to unlock database after $MAX_ATTEMPTS attempts: $(cat "$errfile")"
        exit 1
    fi
    attempt=$((attempt + 1))
done

if [ -z "$entries" ]; then
    notify_err "Database opened but no entries found"
    exit 1
fi

if ! entry=$(printf '%s\n' "$entries" | "${LIST_MENU[@]}" --prompt "Entry: "); then
    exit 0
fi
[ -z "$entry" ] && exit 0

if ! secret=$(printf '%s\n' "$password" | keepassxc-cli show -s -q -a Password "$DB" "$entry" 2>"$errfile"); then
    notify_err "Failed to retrieve entry '$entry': $(cat "$errfile")"
    exit 1
fi
if [ -z "$secret" ]; then
    notify_err "Entry '$entry' has no password field"
    exit 1
fi

sleep 0.3
if ! wtype -- "$secret"; then
    notify_err "wtype failed to type password"
    exit 1
fi
