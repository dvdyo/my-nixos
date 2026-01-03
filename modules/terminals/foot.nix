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
    # 1. Enable System-level Foot (Provides Shell Integration automatically)
    programs.foot.enable = true;

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

    # 3. Manually define foot-server service (Since Hjem/NixOS don't provide it)
    systemd.user.services.foot-server = {
      description = "Foot Terminal Server";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.foot}/bin/foot --server";
        Restart = "always";
      };
    };
  };
}
