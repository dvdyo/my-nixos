{
  lib,
  config,
  pkgs,
  username,
  inputs,
  ...
}:
let
  cfg = config.custom.virtualization.libvirt;
  inherit (lib) mkEnableOption mkIf mkOption;
in
{
  imports = [
    inputs.NixVirt.nixosModules.default
  ];

  options.custom.virtualization.libvirt = {
    enable = mkEnableOption "Enable Libvirt/QEMU virtualization host";

    gui.enable = mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to install virt-manager";
    };
  };

  config = mkIf cfg.enable {
    # NixVirt Integration
    virtualisation.libvirt = {
      enable = true;
      swtpm.enable = true;
    };

    # Core Services
    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };

    # Optional GUI
    programs.virt-manager.enable = cfg.gui.enable;

    # Add user to virtualization groups
    users.users.${username}.extraGroups = [
      "libvirtd"
      "kvm"
    ];
  };
}
