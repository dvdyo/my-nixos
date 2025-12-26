{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.eza;
in
{
  options.custom.programs.eza.enable = lib.mkEnableOption "Enable eza (better ls)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.eza ];
  };
}
