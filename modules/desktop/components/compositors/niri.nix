{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.compositors.niri;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.compositors.niri.enable = mkEnableOption "Enable Niri (Compositor)";

  config = mkIf cfg.enable {
    # 1. System Part (Binary + Portals + Session)
    programs.niri.enable = true;

    # 2. Hardware Prerequisites (Recommended by upstream)
    hardware.graphics.enable = true;

    # 3. User Config (Managed via Hjem Rum)
    custom.core.hjem.cfg.rum.desktops.niri = {
      enable = true;
      package = null; # Use system package

      # Minimal default keybinds so you aren't stuck!
      binds = {
        "Mod+Return" = {
          spawn = [ "ghostty" ];
        };
        "Mod+Q" = {
          action = "close-window";
        };
        "Mod+Shift+E" = {
          action = "quit";
        };
      };

      config = ''
        input {
          keyboard {
            xkb {
              layout "us"
            }
          }
        }
      '';
    };
  };
}
