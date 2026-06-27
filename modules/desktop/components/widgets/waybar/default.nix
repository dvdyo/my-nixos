{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.widgets.waybar;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.widgets.waybar.enable = mkEnableOption "waybar";

  config = mkIf cfg.enable {
    programs.waybar.enable = true;
    programs.waybar.systemd.target = "graphical-session.target";
    };
     custom.hjem.cfg.xdg.config.files."waybar/config" = {
       source = ./config;
     };
    
     custom.hjem.cfg.xdg.config.files."waybar/style.css" = {
      source = ./style.css;
    };
    
    
     custom.hjem.cfg.xdg.config.files."waybar/colors.css" = {
       source = ./colors.css;
       };

     
 }
