{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.screenLockers.gtkclock.enablei;
  inherit (lib) mkEnableOption mkIf;
in
{
  custom.desktop.components.screenLockers.gtkclock.enable = mkEnableOption "Enable gtklock";

  config = mkIf cfg.enable {
      programs.gtklock.enable = true;
      };
    };
  };
}
