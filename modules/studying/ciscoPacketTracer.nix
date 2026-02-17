{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.ciscoPacketTracer;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.ciscoPacketTracer.enable = mkEnableOption "Enable ciscoPacketTracer ";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ciscoPacketTracer9 ];
  };
}
