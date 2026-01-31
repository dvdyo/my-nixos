{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.gaming.steam;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.gaming.steam = {
    enable = mkEnableOption "Enable Steam Gaming Platform";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
