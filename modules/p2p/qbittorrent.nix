{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.p2p.qbittorrent;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.p2p.qbittorrent = {
    enable = mkEnableOption "Enable qBittorrent P2P Client";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      pkgs.qbittorrent
    ];
  };
}
