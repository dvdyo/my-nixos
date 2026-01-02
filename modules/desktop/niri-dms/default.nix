{ lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.niri-dms;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.niri-dms.enable = mkEnableOption "Enable Niri + DMS Desktop Environment";

  config = mkIf cfg.enable {
    # 1. System Packages (Niri + DMS)
    environment.systemPackages = [ pkgs.niri ];

    programs.dms-shell = {
      enable = true;
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      # Core features
      enableSystemMonitoring = true;
      enableClipboard = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };

    # 2. Hardware / Graphics
    hardware.graphics.enable = true;

    # 3. Portals (Required for screencasting and file dialogs)
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        common.default = [ "gtk" ];
        niri = {
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        };
      };
    };

    # 4. User Config (Managed via Hjem Rum)
    custom.hjem.cfg.rum.desktops.niri = {
      enable = true;
      package = null; # Use system package
      config = lib.concatStringsSep "\n" [
	(builtins.readFile ./input.kdl)
        (builtins.readFile ./monitors.kdl)
        (builtins.readFile ./layout.kdl)
        (builtins.readFile ./dms-integration.kdl)
        ''
          // Dynamic Includes from DMS
          include "dms/binds.kdl"
          include "dms/colors.kdl"
          include "dms/alttab.kdl"
          include "dms/wpblur.kdl"
        ''
      ];
    };
  };
}
