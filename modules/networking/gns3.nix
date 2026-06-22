{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.networking.gns3-gui;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.gns3-gui.enable = mkEnableOption "Enable gns3-gui";

  config = mkIf cfg.enable {
    packages = with pkgs; [ gns3-gui ];
  };
}
