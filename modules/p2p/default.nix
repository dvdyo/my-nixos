{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.p2p;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./qbittorrent.nix
    ./nicotine-plus.nix
    ./localsend.nix
  ];

  options.custom.p2p = {
    enable = mkEnableOption "Enable P2P suite";
  };

  config = mkIf cfg.enable {
    custom.p2p = {
      qbittorrent.enable = mkDefault true;
      nicotine-plus.enable = mkDefault true;
      localsend.enable = mkDefault true;
    };
  };
}
