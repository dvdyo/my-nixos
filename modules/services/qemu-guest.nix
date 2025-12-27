{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.qemu-guest;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.qemu-guest.enable = mkEnableOption "Enable QEMU Guest Agent and SPICE agent";

  config = mkIf cfg.enable {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
