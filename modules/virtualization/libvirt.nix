{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.virtualization.libvirt;
  inherit (lib) mkEnableOption mkIf mkOption;
in
{
  options.custom.virtualization.libvirt = {
    enable = mkEnableOption "Enable Libvirt/QEMU virtualization host";

    gui.enable = mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to install virt-manager";
    };
  };

  config = mkIf cfg.enable {
    # Core Services
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    # Optional GUI
    programs.virt-manager.enable = cfg.gui.enable;

    # Add user to virtualization groups
    users.users.${config.custom.core.user.name}.extraGroups = [ 
      "libvirtd" 
      "kvm"
    ];
  };
}
