{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  custom.desktop.xfce.enable = true;

  # Enable programs
  custom.programs.zen.enable = true;

  # Enable VM guest services for convenience
  custom.services.qemu-guest.enable = true;
}