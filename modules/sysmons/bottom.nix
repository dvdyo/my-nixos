{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.bottom;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.bottom.enable = mkEnableOption "Enable bottom sysmon";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.bottom ];
  };
}
