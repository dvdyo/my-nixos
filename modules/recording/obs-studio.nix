{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.recording.obs-studio;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.recording.obs-studio = {
    enable = mkEnableOption "Enable OBS Studio (Screen Recorder & Broadcaster)";
  };

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.obs-studio = {
      enable = true;
      package = pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs # Wayland capture 
          obs-vaapi # Hardware acceleration
          obs-vkcapture # Vulkan game capture
          obs-pipewire-audio-capture # Direct PipeWire capture
        ];
      };
    };
  };
}
