{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.wallpapers.awww;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.wallpapers.awww.enable = mkEnableOption "Enable awww wallpaper daemon";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];

    # Systemd User Service for awww-daemon
    systemd.user.services.awww-daemon = {
      description = "Awww Wallpaper Daemon";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww-daemon";
        # Ensure wallpaper is restored after the daemon starts
        ExecStartPost = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww restore";
        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
