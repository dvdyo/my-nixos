# Shared helpers for nh-search-* scripts.
# This file is concatenated into each script by default.nix via
# builtins.readFile - it is not sourced at runtime, so it has no
# shebang and defines functions only.

# Prompt for free-text input. $1: placeholder text.
nh_search_prompt() {
    fuzzel --dmenu --lines 0 --placeholder "$1"
}

# Read TSV lines (attr\tdisplay) from stdin, show column 2 only.
# $1: placeholder text.
nh_search_pick() {
    fuzzel --dmenu --width 70 --with-nth 2 --placeholder "$1"
}

# Single-column action menu. Reads newline-separated options from stdin.
# $1: placeholder text.
nh_search_pick_action() {
    fuzzel --dmenu --placeholder "$1"
}

nh_search_notify() {
    notify-send "nh search" "$1"
}
