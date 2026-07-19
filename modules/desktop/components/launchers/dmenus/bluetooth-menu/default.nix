{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.bluetoothMenu;
  inherit (lib) mkEnableOption mkIf mkOption types;

  scriptFile = pkgs.replaceVars ./bluetooth-menu.sh {
    scanTimeout = toString cfg.scanTimeout;
  };

  bluetoothMenu = pkgs.writeShellApplication {
    name = "bluetooth-menu";
    runtimeInputs = with pkgs; [
      bluez
      fuzzel
      libnotify
      gawk
      gnused
    ];
    text = ''
      # shellcheck source=/dev/null
      source "${scriptFile}"
    '';
  };

  bluetoothMenuDesktopItem = pkgs.makeDesktopItem {
    name = "bluetooth-menu";
    desktopName = "Bluetooth Menu";
    comment = "a dmenu wrapper for bluetoothctl";
    icon = "bluetooth";
    exec = "${bluetoothMenu}/bin/bluetooth-menu";
    terminal = false;
    categories = [
      "System"
      "Utility"
    ];
    noDisplay = false;
  };
in
{
  options.custom.desktop.components.launchers.dmenus.bluetoothMenu = {
    enable = mkEnableOption "Fuzzel-integrated bluetoothctl dmenu wrapper";

    scanTimeout = mkOption {
      type = types.int;
      default = 8;
      description = "Seconds to scan for nearby Bluetooth devices.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      bluetoothMenu
      bluetoothMenuDesktopItem
    ];
  };
}
