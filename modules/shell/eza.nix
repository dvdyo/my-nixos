{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.eza;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.eza.enable = mkEnableOption "Enable eza (better ls)";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.eza ];
  };
}
