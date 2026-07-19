{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.keepassMenu;
  inherit (lib) mkEnableOption mkIf mkOption types;

  scriptFile = pkgs.replaceVars ./keepass-menu.sh {
    database = cfg.database;
    maxAttempts = toString cfg.maxAttempts;
  };

  keepassMenu = pkgs.writeShellApplication {
    name = "keepass-menu";
    runtimeInputs = with pkgs; [
      keepassxc
      fuzzel
      wtype
      libnotify
    ];
    text = ''
      # shellcheck source=/dev/null
      source "${scriptFile}"
    '';
  };

  keepassMenuDesktopItem = pkgs.makeDesktopItem {
    name = "keepass-menu";
    desktopName = "KeePass Menu";
    comment = "a dmenu wrapper for keepassxc-cli";
    icon = "keepassxc";
    exec = "${keepassMenu}/bin/keepass-menu";
    terminal = false;
    categories = [
      "System"
      "Utility"
    ];
    noDisplay = false;
  };
in
{
  options.custom.desktop.components.launchers.dmenus.keepassMenu = {
    enable = mkEnableOption "Fuzzel-integrated keepassxc-cli dmenu wrapper";

    database = mkOption {
      type = types.path;
      description = "Path to the KeePassXC database (.kdbx) file.";
    };

    maxAttempts = mkOption {
      type = types.int;
      default = 3;
      description = "Number of master-password attempts before giving up.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      keepassMenu
      keepassMenuDesktopItem
    ];
  };
}
