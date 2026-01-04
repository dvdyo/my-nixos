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
  options.custom.desktop.components.compositors.niri.enable = mkEnableOption "Enable Niri Wayland Compositor (Infrastructure)";

  config = mkIf cfg.enable {
    # 1. Enable Official Niri Module (Handles Session, Systemd, Portals)
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    # 2. Additional Tools (Brightness control)
    environment.systemPackages = [ 
      pkgs.brightnessctl
    ];

    # 3. Hardware / Graphics
    hardware.graphics.enable = true;

    # 4. Ensure Greetd can find the session file
    environment.pathsToLink = [ "/share/wayland-sessions" ];
  };
}