{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.qemu-guest;
in
{
  options.custom.services.qemu-guest.enable = lib.mkEnableOption "Enable QEMU Guest Agent and SPICE agent";

  config = lib.mkIf cfg.enable {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
  };
}
