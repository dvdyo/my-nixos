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
    # if the user matches, but standard MPD service usually runs as 'mpd' user.
    # However, setting user = username means it runs as YOU.
    # The default systemd service might restrict home access, so we keep this to be safe,
    # but strictly speaking if User=username, systemd usually allows access to that user's home.
    # We will relax it just in case.
    systemd.services.mpd.serviceConfig.ProtectHome = "read-only"; 
  };
}