{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.compositors.xwayland-satellite;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.compositors.xwayland-satellite = {
    enable = mkEnableOption "Enable XWayland Satellite (X11 support for Niri)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.xwayland-satellite ];

    # Systemd User Service for xwayland-satellite
    systemd.user.services.xwayland-satellite = {
      description = "Xwayland Satellite";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.xwayland-satellite}";
        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}
