{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.screencap.grim;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.screencap.grim = {
    enable = mkEnableOption "Enable Grim (Screenshot Utility)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.grim ];
  };
}
