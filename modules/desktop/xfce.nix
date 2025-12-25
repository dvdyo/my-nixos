{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.xfce;
in {
  options.custom.desktop.xfce.enable = lib.mkEnableOption "Enable XFCE Desktop";

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.xfce.enable = true;
      displayManager.lightdm.enable = true;
    };
    
    # Optional: Install standard XFCE plugins/tools
    environment.systemPackages = with pkgs; [
      xfce.xfce4-whiskermenu-plugin
      xfce.xfce4-pulseaudio-plugin
    ];
  };
}
