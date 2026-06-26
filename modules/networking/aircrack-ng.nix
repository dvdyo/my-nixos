{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.networking.aircrack-ng;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.aircrack-ng.enable = mkEnableOption "Enable aircrack-ng";

  config = mkIf cfg.enable {
    environment.systemPackages =  [ pkgs.aircrack-ng ];
  };
}
