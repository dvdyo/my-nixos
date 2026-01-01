{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.environments.niri-dms;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.environments.niri-dms.enable = mkEnableOption "Enable Niri + Dank Material Shell Environment";

  config = mkIf cfg.enable {
    # Enable Components
    custom.desktop.components = {
      wlCompositors.niri.enable = true;
      shells.dms.enable = true;
      fonts.enable = true;
    };
  };
}
