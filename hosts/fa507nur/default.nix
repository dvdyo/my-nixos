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

  # Change this after first login
  users.users.dvd.initialPassword = "password";
}
