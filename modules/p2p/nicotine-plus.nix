{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.p2p.nicotine-plus;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.p2p.nicotine-plus = {
    enable = mkEnableOption "Enable Nicotine+ Soulseek Client";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nicotine-plus
    ];
  };
}
