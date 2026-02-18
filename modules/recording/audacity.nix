{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.recording.audacity;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.recording.audacity = {
    enable = mkEnableOption "Enable Audacity (Audio Editor & Recorder)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.audacity ];
  };
}
