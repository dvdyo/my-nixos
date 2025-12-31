{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.environments.xfce;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.environments.xfce.enable = mkEnableOption "Enable XFCE Desktop";

  config = mkIf cfg.enable {
    # Dependencies
    custom.desktop.components.fonts.enable = lib.mkDefault true;

    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
    };

    # Optional: Install standard XFCE plugins/tools
    environment.systemPackages = with pkgs; [
      xfce4-whiskermenu-plugin
      xfce4-pulseaudio-plugin
    ];
  };
}
