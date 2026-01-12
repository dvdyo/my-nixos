{ lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.wallpapers.awww;
  inherit (lib) mkEnableOption mkIf;

  # Binary path aliases for readability and robustness
  awwwPkg = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
  awww = lib.getExe awwwPkg;
  awww-daemon = lib.getExe' awwwPkg "awww-daemon";
  
  grep = lib.getExe pkgs.gnugrep;
  sleep = lib.getExe' pkgs.coreutils "sleep";
  sh = lib.getExe' pkgs.bash "sh";
in
{
  options.custom.desktop.components.wallpapers.awww.enable = mkEnableOption "Enable awww wallpaper daemon";

  config = mkIf cfg.enable {
    environment.systemPackages = [ awwwPkg ];

    # Systemd User Service for awww-daemon
    systemd.user.services.awww-daemon = {
      description = "Awww Wallpaper Daemon";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = awww-daemon;
        
        # Wait until the daemon detects wayland outputs before restoring
        ExecStartPost = "${sh} -c 'while ! ${awww} query | ${grep} -q ":"; do ${sleep} 0.2; done; ${awww} restore'";

        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}