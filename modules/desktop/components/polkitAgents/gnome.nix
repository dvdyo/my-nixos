{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.polkitAgents.gnome;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.polkitAgents.gnome.enable = mkEnableOption "Enable GNOME Polkit Authentication Agent";

  config = mkIf cfg.enable {
    # Install the package so the binary is available (and icons etc)
    environment.systemPackages = [ pkgs.polkit_gnome ];

    # Systemd User Service
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "GNOME Polkit Authentication Agent";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 5;
        # Since this is a GUI app, it might not strictly need the PATH hack if it doesn't spawn children,
        # but it definitely needs the Session Environment (DISPLAY/WAYLAND_DISPLAY) which Systemd provides.
      };
    };
  };
}
