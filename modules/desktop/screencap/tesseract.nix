{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.screencap.tesseract;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.screencap.tesseract = {
    enable = mkEnableOption "Enable tesseract";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.tesseract ];
  };
}
