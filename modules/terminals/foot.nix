{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.terminals.foot;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.terminals.foot.enable = mkEnableOption "Enable Foot Terminal";

  config = mkIf cfg.enable {
    # 1. Enable Hjem Rum Foot module
    custom.hjem.cfg.rum.programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
          term = "xterm-256color";
          pad = "12x12";
          shell = "${pkgs.fish}/bin/fish";
        };
        mouse = {
          hide-when-typing = "yes";
        };
        colors = {
          alpha = 0.95;
          foreground = "cdd6f4"; # Catppuccin Mocha-ish
          background = "1e1e2e";
        };
      };
    };

    # 2. Enable foot-server systemd service for instant startup via footclient
    services.foot-server.enable = true;
  };
}
