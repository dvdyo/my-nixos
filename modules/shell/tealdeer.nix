{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.tealdeer;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.shell.tealdeer.enable = mkEnableOption "Enable tealdeer (tldr client)";

  config = mkIf cfg.enable {
    # 1. System-wide Install
    environment.systemPackages = [ pkgs.tealdeer ];

    # 2. User Config (Managed via Hjem Rum)
    custom.hjem.cfg.rum.programs.tealdeer = {
      enable = true;
      package = null; # Use system package
      settings = {
        updates = {
          auto_update = mkDefault true;
        };
      };
    };
  };
}
