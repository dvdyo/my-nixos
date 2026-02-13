{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.sysmons.bottom;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.sysmons.bottom.enable = mkEnableOption "Enable bottom sysmon";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.bottom ];
  };
}
