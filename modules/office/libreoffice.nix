{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.office.libreoffice;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.office.libreoffice = {
    enable = mkEnableOption "Enable LibreOffice Suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      # Standard fresh version (GTK-based backend by default on Wayland)
      # Switch to 'libreoffice-qt6-fresh' later if Qt theming is preferred.
      pkgs.libreoffice-fresh
    ];
  };
}
