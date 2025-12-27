{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.eza;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.eza.enable = mkEnableOption "Enable eza (better ls)";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.eza ];
  };
}
