{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.audio;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.audio.enable = mkEnableOption "Enable Pipewire Audio";

  config = mkIf cfg.enable {
    # RTKit is needed for PipeWire to get real-time priority
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true; # PulseAudio emulation
      wireplumber.enable = true; # Session manager
    };
  };
}
