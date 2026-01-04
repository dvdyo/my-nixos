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
        
        # Wait until the daemon detects wayland outputs before restoring
        ExecStartPost = "${pkgs.bash}/bin/sh -c 'while ! ${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww query | ${pkgs.gnugrep}/bin/grep -q \":\"; do ${pkgs.coreutils}/bin/sleep 0.2; done; ${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww restore'";

        Restart = "always";
        RestartSec = 5;
      };
    };
  };
}
