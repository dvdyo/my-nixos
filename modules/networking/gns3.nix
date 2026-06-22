{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.networking.gns3;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.gns3.enable = mkEnableOption "Enable gns3";

  config = mkIf cfg.enable {
    environment.systemPackages =  [ pkgs.gns3-gui ];
    services.gns3-server = {
      enable = true;
      vpcs.enable = true;
      dynamips.enable = true;
      ubridge.enable = true;
    };
  };
}
