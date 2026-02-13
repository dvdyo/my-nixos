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
in
{
  options.custom.media.mpd = {
    enable = mkEnableOption "Enable MPD (Music Player Daemon)";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      user = "${username}";
      startWhenNeeded = true;
      # Use the new structured settings option
      settings = {
        music_directory = "/home/${username}/Music";
        # Audio Outputs
        audio_output = [
          {
            type = "pipewire";
            name = "My PipeWire Output";
          }
          {
            type = "fifo";
            name = "my_fifo";
            path = "/tmp/mpd.fifo";
            format = "44100:16:2";
          }
        ];
      };
    };

    # PipeWire Workaround:
    # Since MPD runs as a system service (even with user=username), it doesn't inherit the user's
    # environment variables. We must explicitly point it to the user's Runtime Directory
    # so it can find the PipeWire socket (usually at /run/user/<uid>/pipewire-0).
    systemd.services.mpd = {
      
      environment = {
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";
      };
    };
  };
}
