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
    # 1. System Packages (Manual install since we aren't using programs.foot system module)
    environment.systemPackages = [ pkgs.foot ];

    # 2. Enable Hjem Rum Foot module (Provides User Config)
    custom.hjem.cfg.rum.programs.foot = {
      enable = true;
      package = null; # Use system package
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
          term = "xterm-256color";
          pad = "12x12";
          shell = "${pkgs.fish}/bin/fish";
        };
        csd = {
          preferred = "none";
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
  };
}
