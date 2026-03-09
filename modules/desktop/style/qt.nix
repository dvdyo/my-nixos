{ lib, config, pkgs, ... }:
let
  cfg = config.custom.desktop.style.qt;
  inherit (lib) mkEnableOption mkIf;
in {
  options.custom.desktop.style.qt = {
    enable = mkEnableOption "Enable Qt theming (Gruvbox/Kvantum)";
  };

  config = mkIf cfg.enable {
    # Qt platform + style engine
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";  # force Qt apps onto Wayland
    };
    # Gruvbox Kvantum theme package
    environment.systemPackages = [
      (pkgs.gruvbox-kvantum.override { variant = "Gruvbox-Dark-Blue"; })
    ];

    # Tell Kvantum which theme to use
    custom.hjem.cfg.files = {
      ".config/Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Gruvbox-Dark-Blue
      '';
    };
  };
}
