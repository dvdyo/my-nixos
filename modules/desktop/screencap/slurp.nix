{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.screencap.slurp;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.screencap.slurp = {
    enable = mkEnableOption "Enable Slurp (Region Selector)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.slurp ];
  };
}
