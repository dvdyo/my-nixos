{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.networking.iw;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.iw.enable = mkEnableOption "Enable iw";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
      iw
    ];
  };
}
