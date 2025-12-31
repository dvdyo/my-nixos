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

  # User Password (Initial)
  # Change this with `passwd` after first login!
  users.users.dvd.initialPassword = "password";
}
