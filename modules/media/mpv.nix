{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.media.mpv;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.media.mpv = {
    enable = mkEnableOption "Enable MPV Media Player";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.yt-dlp ];

    custom.hjem.cfg.rum.programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        sponsorblock
        mpris
        uosc
        thumbfast
      ];
      config = {
        # Video output
        vo = "gpu-next";
        profile = "gpu-hq";
        hwdec = "auto-safe";

        # Scaling
        scale = "ewa_lanczos";
        cscale = "ewa_lanczos";
        dscale = "mitchell";
        
        # Debanding
        deband = true;
        deband-iterations = 4;
        deband-threshold = 48;
        deband-range = 16;

        # Streaming
        ytdl-format = "bestvideo+bestaudio";

        # OSD — replaced by uosc
        osd-bar = false;
        border = false;

        # OSD font (used for stats etc, not the main UI)
        osd-font = "JetBrainsMono Nerd Font";
        osd-font-size = 32;

        # Subtitles
        sub-auto = "fuzzy";
        slang = "eng,en";
        sub-font = "JetBrainsMono Nerd Font";
        sub-font-size = 44;
        sub-shadow-offset = 1;
        sub-bold = true;
      };
    };
  };
}
