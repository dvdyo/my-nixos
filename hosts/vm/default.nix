{
  pkgs,
  inputs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./networking.nix
    ./impermanence.nix
    ../../roles/testsubject.nix
  ];

  # --- Hardware / Boot ---
  system.stateVersion = "26.05";
  # Standard QEMU/KVM modules
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "virtio_pci"
    "virtio_blk"
    "ahci"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  # --- Host Identity ---
  networking.hostName = "vm";

  # --- User Config ---
  users.users.dvd.initialPassword = "password";
}
