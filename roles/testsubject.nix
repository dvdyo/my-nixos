{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  custom.desktop.environments.xfce.enable = true;

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
