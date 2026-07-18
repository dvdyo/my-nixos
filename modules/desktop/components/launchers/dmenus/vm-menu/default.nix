{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.vmMenu;
  inherit (lib) mkEnableOption mkIf;

  vmMenu = pkgs.writeShellApplication {
    name = "vm-menu";
    runtimeInputs = with pkgs; [
      libvirt # virsh
      virt-viewer
      fuzzel
      libnotify # notify-send
      gnugrep # grep -P used for network-name extraction
    ];
    text = builtins.readFile ./vm-menu.sh;
  };

  vmMenuDesktopItem = pkgs.makeDesktopItem {
    name = "vm-menu";
    desktopName = "VM Menu";
    comment = "Start, connect, shutdown, or reboot a libvirt VM";
    icon = "virt-manager";
    exec = "${vmMenu}/bin/vm-menu";
    terminal = false;
    categories = [
      "System"
      "Utility"
    ];
    noDisplay = false;
  };
in
{
  options.custom.desktop.components.launchers.dmenus.vmMenu.enable =
    mkEnableOption "Fuzzel-integrated libvirt VM launcher (start/connect/shutdown/reboot)";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      vmMenu
      vmMenuDesktopItem
    ];
  };
}
