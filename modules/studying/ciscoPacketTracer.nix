{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.studying.ciscoPacketTracer;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.studying.ciscoPacketTracer.enable = mkEnableOption "Enable ciscoPacketTracer ";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ciscoPacketTracer9 ];
  };
}
