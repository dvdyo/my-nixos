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
    ./virtio-win.nix
  ];

  options.custom.virtualization = {
    enable = mkEnableOption "Enable Virtualization suite";
  };

  config = mkIf cfg.enable {
    custom.virtualization = {
      libvirt.enable = mkDefault true;
      virtio-win.enable = mkDefault false;
    };
  };
}
