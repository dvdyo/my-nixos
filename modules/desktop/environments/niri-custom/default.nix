{
  lib,
  config,
  pkgs,
  ...}:
let
  cfg = config.custom.desktop.environments.niri-custom;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.environments.niri-custom.enable = mkEnableOption "Enable Custom Niri Environment";

  config = mkIf cfg.enable {
    # 1. Enable Infrastructure & Components
    custom.desktop.components = {
      compositors.niri.enable = true;
      launchers.vicinae.enable = true;
      wallpapers.awww.enable = true;
      fonts.enable = true;
    };

    # 2. Environment Configuration
    custom.hjem.cfg.rum.desktops.niri = {
      enable = true;
      package = null;
      config = lib.concatStringsSep "\n" [
        (builtins.readFile ./input.kdl)
        (builtins.readFile ./monitors.kdl)
        (builtins.readFile ./layout.kdl)
        (builtins.readFile ./binds.kdl)
        (builtins.readFile ./spawns.kdl)
        (builtins.readFile ./animations.kdl)
      ];
    };
  };
}

