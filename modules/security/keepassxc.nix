{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.security.keepassxc;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.security.keepassxc = {
    enable = mkEnableOption "Enable KeePassXC Password Manager";
  };

  config = mkIf cfg.enable {
    # We use the Hjem Rum module to manage the package and its configuration
    custom.hjem.cfg.rum.programs.keepassxc = {
      enable = true;
      package = pkgs.keepassxc;
      settings = {
        General = {
          ConfigVersion = 2;
        };
        GUI = {
          # No System Tray in Niri (by default), so do NOT minimize to tray.
          MinimizeToTray = false;
          MinimizeOnClose = false;
          ShowTrayIcon = false;
        };
        Browser = {
          Enabled = true;
        };
      };
    };
  };
}