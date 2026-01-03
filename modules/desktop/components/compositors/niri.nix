{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.compositors.niri;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.compositors.niri.enable = mkEnableOption "Enable Niri Wayland Compositor (Infrastructure)";

  config = mkIf cfg.enable {
    # 1. System Packages
    environment.systemPackages = [ pkgs.niri ];

    # 2. Portals (Required for Niri basics)
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = [ "gtk" ];
        niri = {
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
      };
    };

    # 3. Hardware / Graphics
    hardware.graphics.enable = true;
  };
}