{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./hardware.nix
    inputs.disko.nixosModules.disko
    ../../roles/workstation.nix
  ];
  system.stateVersion = "26.05";
  networking.hostName = "fa507nur";
  # Change this after first login
  users.users.dvd.initialPassword = "password";
}
