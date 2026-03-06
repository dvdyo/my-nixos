{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.services.printing;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.printing.enable = mkEnableOption "Enable printing";

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [ pkgs.splix ];
    };
  };
}
