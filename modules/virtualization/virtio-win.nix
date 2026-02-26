{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.virtualization.virtio-win;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.virtualization.virtio-win.enable =
    mkEnableOption "Enable virtio-win driver installation";

  config = mkIf cfg.enable {
    environmnment.systemPackages = [ pkgs.virtio-win ];
  };
}
