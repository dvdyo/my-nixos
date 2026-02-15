{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.custom.media.mpd;
  inherit (lib) mkEnableOption mkIf;

  mpdConfig = ''
    music_directory     "/home/${username}/Music"
    playlist_directory  "/home/${username}/.config/mpd/playlists"
    db_file             "/home/${username}/.config/mpd/database"
    log_file            "syslog"
    pid_file            "/home/${username}/.config/mpd/pid"
    state_file          "/home/${username}/.config/mpd/state"
    sticker_file        "/home/${username}/.config/mpd/sticker.sql"
    bind_to_address     "127.0.0.1"
    port                "6600"
    auto_update         "yes"

    audio_output {
        type            "pipewire"
        name            "PipeWire Output"
    }

    audio_output {
        type            "fifo"
        name            "Visualizer FIFO"
        path            "/tmp/mpd.fifo"
        format          "44100:16:2"
    }
  '';
in
{
  options.custom.media.mpd = {
    enable = mkEnableOption "Enable MPD (Music Player Daemon)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.mpd
      pkgs.mpc
    ];

    services.mpd.enable = false;

    systemd.user.services.mpd = {
      description = "Music Player Daemon";
      after = [ "network.target" "sound.target" "pipewire.service" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.mpd} --no-daemon /home/${username}/.config/mpd/mpd.conf";
        Restart = "on-failure";
        ProtectHome = "read-only";
      };
    };

    custom.hjem.cfg.files = {
      ".config/mpd/mpd.conf".text = mpdConfig;
      ".config/mpd/playlists/.keep".text = "";
    };
  };
}
