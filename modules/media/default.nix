{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.media;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./mpv.nix
  ];

  options.custom.media = {
    enable = mkEnableOption "Enable Media suite";
  };

  config = mkIf cfg.enable {
    custom.media = {
      mpv.enable = mkDefault true;
    };
  };
}
