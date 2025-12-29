{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../roles/workstation.nix
  ];

  networking.hostName = "fa507nur";

  # Bootloader (UEFI)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # User Password (Initial)
  # Change this with `passwd` after first login!
  users.users.dvd.initialPassword = "password";
}
