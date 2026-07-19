{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.powerMenu;
  inherit (lib) mkEnableOption mkIf concatMapStrings;

  mkPowerScript =
    name: scriptFile:
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [
        fuzzel
        libnotify
        systemd
      ];
      extraShellCheckFlags = [ "-x" ];
      text = concatMapStrings (f: ''
        # shellcheck source=${f}
        source ${f}
      '') [
        ./lib.sh
        scriptFile
      ];
    };

  poweroff = mkPowerScript "power-off" ./poweroff.sh;
  reboot = mkPowerScript "power-reboot" ./reboot.sh;
  softReboot = mkPowerScript "power-soft-reboot" ./soft-reboot.sh;

  mkPowerDesktopItem =
    name: desktopName: comment: icon: pkg:
    pkgs.makeDesktopItem {
      inherit name desktopName comment icon;
      exec = "${pkg}/bin/${pkg.meta.mainProgram or pkg.name}";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
      noDisplay = false;
    };

  poweroffDesktopItem = mkPowerDesktopItem "power-off" "Power Off" "Shut down the system" "system-shutdown" poweroff;
  rebootDesktopItem = mkPowerDesktopItem "power-reboot" "Reboot" "Restart the system" "system-reboot" reboot;
  softRebootDesktopItem =
    mkPowerDesktopItem "power-soft-reboot" "Soft Reboot" "Restart userspace without firmware reinit"
      "system-reboot"
      softReboot;
in
{
  options.custom.desktop.components.launchers.dmenus.powerMenu.enable =
    mkEnableOption "Fuzzel-searchable power commands (poweroff/reboot/soft-reboot) with confirmation";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      poweroff
      reboot
      softReboot
      poweroffDesktopItem
      rebootDesktopItem
      softRebootDesktopItem
    ];
  };
}
