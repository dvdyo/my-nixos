{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.cursors.phinger;
  inherit (lib) mkEnableOption mkIf;
 in
{
  options.custom.desktop.components.cursors.phinger = {
    enable = mkEnableOption "Enable phinger cursor";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.phinger-cursors ];

  };
}
