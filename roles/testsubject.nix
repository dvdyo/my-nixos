{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  custom.desktop.environments.xfce.enable = false;
  custom.desktop.components.compositors.niri.enable = true;
  custom.desktop.components.fonts.enable = true;

  # Enable programs
  custom.browsers.zen.enable = true;
  custom.terminals.ghostty.enable = true;

  # Enable VM guest services for convenience
  custom.virtualization.qemu-guest.enable = true;

  # Enable Libvirt Host (Nested Virtualization test)
  custom.virtualization.libvirt.enable = true;

  # Enable Android Debugger Bridge
  custom.services.adb.enable = true;
}
