{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.fuzzel;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.launchers.fuzzel.enable =
    mkEnableOption "Enable fuzzel Launcher";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fuzzel ];
    custom.hjem.cfg.xdg.config.files."fuzzel/fuzzel.ini" = {
      source = ./fuzzel.ini;
    };
    
  };
}
