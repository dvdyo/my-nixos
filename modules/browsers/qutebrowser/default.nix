{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.browsers.qutebrowser;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.browsers.qutebrowser.enable = mkEnableOption "Enable qutebrowser";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qutebrowser ];
    permittedInsecurePackages = [
      "qutebrowser-3.7.0"
    ];

    custom.hjem.cfg.xdg.config.files."qutebrowser/config.py" = {
      source = ./config.py;
    };
  };
}
