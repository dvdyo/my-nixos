{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.screencap.satty;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.screencap.satty = {
    enable = mkEnableOption "Enable Satty (Screenshot Editor)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      pkgs.satty
      pkgs.wl-clipboard # Required for "Copy to Clipboard" action in Satty
    ];
  };
}
