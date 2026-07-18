{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.clipboard.clipsuite;
  inherit (lib) mkEnableOption mkIf getExe getExe';
in
{
  options.custom.desktop.clipboard.clipsuite = {
    enable = mkEnableOption "clipboard suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
      wl-clipboard
      cliphist
    ];
    systemd.user.services.cliphist-text = {
      description = "cliphist text clipboard listener";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${getExe pkgs.cliphist} store";
        Restart = "on-failure";
        RestartSec = "1s";
      };
    };

    systemd.user.services.cliphist-image = {
      description = "cliphist image clipboard listener";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${getExe pkgs.cliphist} store";
        Restart = "on-failure";
        RestartSec = "1s";
      };
    };

  };
}
