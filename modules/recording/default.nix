{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.recording;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./audacity.nix
    ./obs-studio.nix
  ];

  options.custom.recording = {
    enable = mkEnableOption "Enable Recording suite";
  };

  config = mkIf cfg.enable {
    custom.recording = {
      audacity.enable = mkDefault true;
      obs-studio.enable = mkDefault true;
    };
  };
}
