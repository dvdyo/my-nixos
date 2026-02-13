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
    # 1. Install yt-dlp for streaming support
    environment.systemPackages = [ pkgs.yt-dlp ];

    # 2. Configure MPV via Hjem Rum
    custom.hjem.cfg.rum.programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        sponsorblock
        mpris
      ];
      config = {
        # Video quality & hardware acceleration
        ytdl-format = "bestvideo+bestaudio";
        hwdec = "auto-safe";
        vo = "gpu-next";
        profile = "gpu-hq";
        
        # UI/UX
        osd-font = "JetBrainsMono Nerd Font";
        osd-font-size = 32;
        
        # Subtitles
        sub-auto = "fuzzy";
        slang = "eng,en";
      };
    };
  };
}
