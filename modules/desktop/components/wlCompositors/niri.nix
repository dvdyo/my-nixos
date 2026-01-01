{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.wlCompositors.niri;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.desktop.components.wlCompositors.niri.enable = mkEnableOption "Enable niri Wayland compositor";

  config = mkIf cfg.enable {
    # 1. System-wide Install
    environment.systemPackages = [ pkgs.niri ];

    # 2. User Config (Managed via Hjem Rum)
    custom.hjem.cfg.rum.desktop.niri = {
      enable = true;
      package = null; # Use system package
      };
    };
  };
}
