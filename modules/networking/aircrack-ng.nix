{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.networking.aricrack-ng;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.aricrack-ng.enable = mkEnableOption "Enable aricrack-ng";

  config = mkIf cfg.enable {
    environment.systemPackages =  [ pkgs.aricrack-ng ];
  };
}
