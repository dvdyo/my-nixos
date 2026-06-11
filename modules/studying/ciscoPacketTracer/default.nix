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
  options.custom.studying.ciscoPacketTracer.enable = mkEnableOption "Enable ciscoPacketTracer";
  config = mkIf cfg.enable {
    programs.firejail = {
      enable = true;
      wrappedBinaries = {
        packettracer9 = {
          executable = lib.getExe pkgs.ciscoPacketTracer9;
          desktop = "${pkgs.ciscoPacketTracer9}/share/applications/cisco-packet-tracer-9.desktop";
          extraArgs = [
            "--net=none"
            "--noprofile"
          ];
        };
      };
    };
  };
}
