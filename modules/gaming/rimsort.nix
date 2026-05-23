{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.gaming.rimsort;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.gaming.rimsort.enable = mkEnableOption "Enable rimsort";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.rimsort ];
  };
}
