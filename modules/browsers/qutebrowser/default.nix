{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.custom.browsers.qutebrowser;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.browsers.qutebrowser.enable = mkEnableOption "Enable qutebrowser";

  config = mkIf cfg.enable {
      environment.systemPackages = with pkgs;
      [ qutebrowser ];
      custom.hjem.cfg.xdg.config.files."qutebrowser/config.py" = {      
      source = ./config.py;
    };
    };
}
