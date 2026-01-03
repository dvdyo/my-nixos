{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.vicinae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.launchers.vicinae.enable = mkEnableOption "Enable Vicinae Launcher";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vicinae ];
  };
}
