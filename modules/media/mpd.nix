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
      user = username;
      
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

        # Ensure the music directory exists or at least the path is valid

        # Since we are running as the user, we don't strictly need ProtectHome = read-only modification

        # but strictly speaking if User=username, systemd usually allows access to that user's home.

        # We will relax it just in case.

        systemd.services.mpd = {

          serviceConfig.ProtectHome = "read-only";

          environment = {

            # Required for MPD (system service) to find the user's PipeWire socket

            XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.${username}.uid}";

          };

        };

      };

    }

    