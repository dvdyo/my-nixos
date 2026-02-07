{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.virtualization;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./qemu-guest.nix
    ./libvirt.nix
  ];

  options.custom.virtualization = {
    enable = mkEnableOption "Enable Virtualization suite";
  };

  config = mkIf cfg.enable {
    custom.virtualization = {
      qemu-guest.enable = mkDefault true;
      libvirt.enable = mkDefault true;
    };
  };
}