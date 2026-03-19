{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.screenLockers.gtklock;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.screenLockers.gtklock.enable = mkEnableOption "Enable gtklock";

  config = mkIf cfg.enable {
    programs.gtklock.enable = true;
  };
}
