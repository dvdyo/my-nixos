LIMIT="${NH_SEARCH_FUZZEL_LIMIT:-40}"
TERMINAL="${NH_SEARCH_TERMINAL:-footclient}"

query=$(nh_search_prompt "Search nixpkgs...") || exit 0
[ -z "$query" ] && exit 0

results=$(nh search packages "$query" --json --limit "$LIMIT" 2>/dev/null) || {
    nh_search_notify "Search failed (no network, or nh error)"
    exit 1
}

count=$(printf '%s' "$results" | jq '.results | length')
if [ "$count" -eq 0 ]; then
    nh_search_notify "No results for '$query'"
    exit 0
fi

selection=$(printf '%s' "$results" | jq -r '
    .results[]
    | [
        .package_attr_name,
        (
          .package_pname
          + " (" + .package_pversion + ") — "
          + ((.package_description // "no description") | gsub("[\t\n]"; " "))
        )
      ]
    | @tsv
' | nh_search_pick "Select package...")

[ -z "$selection" ] && exit 0
attr=$(printf '%s' "$selection" | cut -f1)

action=$(printf '%s\n%s\n%s\n%s\n' \
    "Copy attribute name ($attr)" \
    "Copy nixpkgs#$attr" \
    "nix shell nixpkgs#$attr (open terminal)" \
    "nix run nixpkgs#$attr" \
    | nh_search_pick_action "Action for $attr...")

[ -z "$action" ] && exit 0

case "$action" in
    "Copy attribute name"*)
        printf '%s' "$attr" | wl-copy
        nh_search_notify "Copied '$attr'"
        ;;
    "Copy nixpkgs#"*)
        printf 'nixpkgs#%s' "$attr" | wl-copy
        nh_search_notify "Copied 'nixpkgs#$attr'"
        ;;
    "nix shell"*)
        "$TERMINAL" -e sh -c "nix shell nixpkgs#$attr; exec \$SHELL" &
        ;;
    "nix run"*)
        nix run "nixpkgs#$attr" &
        ;;
esac
