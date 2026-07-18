{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.nhSearch;
  inherit (lib) mkEnableOption mkIf concatMapStrings;

  # Builds one writeShellApplication by concatenating lib.sh with a
  # script-specific file. shellcheck runs on the combined result at
  # build time, so a broken function reference fails the build rather
  # than failing silently at runtime.
  mkSearchScript =
    name: scriptFile:
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [
        nh
        fuzzel
        jq
        wl-clipboard
        libnotify
        xdg-utils
      ];
      text = concatMapStrings (f: builtins.readFile f + "\n") [
        ./lib.sh
        scriptFile
      ];
    };

  searchPackages = mkSearchScript "nh-search-packages" ./search-packages.sh;
  searchOptions = mkSearchScript "nh-search-options" ./search-options.sh;

  nhSearchPackagesDesktopItem  = pkgs.makeDesktopItem {
    name = "nh-search-packages";
    desktopName = "Nix Search Packages";
    comment = "a dmenu wrapper for nh search";
    icon = "nix-snowflake";
    exec = "${searchPackages}/bin/nh-search-packages";
    terminal = false;
    categories = [
      "System"
      "Utility"
    ];
    noDisplay = false;
  };
  nhSearchOptionsDesktopItem  = pkgs.makeDesktopItem {
    name = "nh-search-options";
    desktopName = "Nix Search Options";
    comment = "a dmenu wrapper for nh search";
    icon = "nix-snowflake";
    exec = "${searchOptions}/bin/nh-search-options";
    terminal = false;
    categories = [
      "System"
      "Utility"
    ];
    noDisplay = false;
  };

in
{
  options.custom.desktop.components.launchers.dmenus.nhSearch.enable =
    mkEnableOption "Fuzzel-integrated nh search (nixpkgs packages + NixOS options)";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      searchPackages
      searchOptions
      nhSearchPackagesDesktopItem
      nhSearchOptionsDesktopItem
    ];

  };
}
