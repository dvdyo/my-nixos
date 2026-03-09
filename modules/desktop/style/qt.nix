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
        custom.hjem.cfg.files = {
      # Tell qt5ct to use kvantum as its style engine
      ".config/qt5ct/qt5ct.conf".text = ''
        [Appearance]
        style=kvantum
        icon_theme=Gruvbox-Plus-Dark

        [Fonts]
        fixed="JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0"
        general="JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0"
      '';

      # Tell qt6ct the same
      ".config/qt6ct/qt6ct.conf".text = ''
        [Appearance]
        style=kvantum
        icon_theme=Gruvbox-Plus-Dark

        [Fonts]
        fixed="JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0"
        general="JetBrainsMono Nerd Font,11,-1,5,50,0,0,0,0,0"
      '';

      # Tell Kvantum which gruvbox variant to use
      ".config/Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Gruvbox-Dark-Brown
      '';
      ".config/Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Gruvbox-Dark-Blue
      '';
    };
  };
}
