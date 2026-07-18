BROWSER_CMD="${BROWSER:-xdg-open}"
LIMIT="${NH_SEARCH_FUZZEL_LIMIT:-40}"

query=$(nh_search_prompt "Search NixOS options...") || exit 0
[ -z "$query" ] && exit 0

results=$(nh search options "$query" --json --limit "$LIMIT" --scope=nixpkgs 2>/dev/null) || {
    nh_search_notify "Search failed (no network, or nh error)"
    exit 1
}

count=$(printf '%s' "$results" | jq '.results | length')
if [ "$count" -eq 0 ]; then
    nh_search_notify "No NixOS options for '$query'"
    exit 0
fi

# select(.type == "option") is a belt-and-suspenders filter on top of
# --scope=nixpkgs, since home-manager-option entries have been observed
# even with that scope set.
selection=$(printf '%s' "$results" | jq -r '
    .results[]
    | select(.type == "option")
    | [
        .option_name,
        (
          .option_name
          + " (" + (.option_type // "unknown") + ") — "
          + (
              (.option_description // "no description")
              | gsub("<[^>]*>"; " ")
              | gsub("[\t\n]"; " ")
              | gsub(" +"; " ")
              | ltrimstr(" ") | rtrimstr(" ")
            )
        )
      ]
    | @tsv
' | nh_search_pick "Select option...")

[ -z "$selection" ] && exit 0
opt=$(printf '%s' "$selection" | cut -f1)

action=$(printf '%s\n%s\n%s\n' \
    "Copy option name ($opt)" \
    "Copy '$opt = ;' skeleton" \
    "Open on search.nixos.org" \
    | nh_search_pick_action "Action for $opt...")

[ -z "$action" ] && exit 0

case "$action" in
    "Copy option name"*)
        printf '%s' "$opt" | wl-copy
        nh_search_notify "Copied '$opt'"
        ;;
    "Copy '"*"'"*)
        printf '%s = ;' "$opt" | wl-copy
        nh_search_notify "Copied '$opt = ;'"
        ;;
    "Open on search.nixos.org"*)
        "$BROWSER_CMD" "https://search.nixos.org/options?query=$(printf '%s' "$opt" | sed 's/ /%20/g')" &
        ;;
esac
