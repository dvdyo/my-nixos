{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  custom.desktop.environments.xfce.enable = true;

  # Enable programs
  custom.browsers.zen.enable = true;

  # Enable VM guest services for convenience
  custom.virtualization.qemu-guest.enable = true;

  # Enable Libvirt Host (Nested Virtualization test)
  custom.virtualization.libvirt.enable = true;

  # Enable Android Dev (SDK + Studio)
  custom.devel.android.enable = true;
}
