{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.media.easyeffects;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.media.easyeffects = {
    enable = mkEnableOption "Enable easyeffects (equalizer)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.easyeffects
    ];
  };
}
