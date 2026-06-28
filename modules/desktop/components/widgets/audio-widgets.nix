{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.widgets.audio-widgets;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.widgets.audio-widgets.enable = mkEnableOption "audio-widgets";

  config = mkIf cfg.enable {
      environment.systemPackages = [ pkgs.helvum pkgs.pavucontrol ];
    };
     
 }
