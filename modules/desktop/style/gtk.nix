{ lib, config, pkgs, ... }:
let
  cfg = config.custom.desktop.style.gtk;
  inherit (lib) mkEnableOption mkIf;
in {
  options.custom.desktop.style.gtk = {
    enable = mkEnableOption "Enable centralized desktop styling (Gruvbox)";
  };

  config = mkIf cfg.enable {
    # System-wide Theme Packages
    environment.systemPackages = [
      pkgs.gruvbox-material-gtk-theme          
      pkgs.gruvbox-plus-icon  
      pkgs.bibata-cursors              
    ];

    # GTK Configuration via Hjem Rum
    custom.hjem.cfg.rum.misc.gtk = {
      enable = true;
      settings = {
        theme-name = "Gruvbox-Dark";           # or "Gruvbox-Dark-BL" (borderless)
        icon-theme-name = "Gruvbox-Plus-Dark"; # from gruvbox-plus-icon-theme
        cursor-theme-name = "Bibata-Modern-Classic";
        font-name = "JetBrainsMono Nerd Font 11";
        application-prefer-dark-theme = true;
        cursor-theme-size = 24;
        toolbar-style = "GTK_TOOLBAR_ICONS";
        toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        button-images = 0;
        menu-images = 0;
        enable-event-sounds = 0;
        enable-input-feedback-sounds = 0;
        xft-antialias = 1;
        xft-hinting = 1;
        xft-hintstyle = "hintslight";
        xft-rgba = "rgb";
      };

      css.gtk3 = ''
        scrollbar {
            -GtkScrollbar-has-backward-stepper: 0;
            -GtkScrollbar-has-forward-stepper: 0;
        }
      '';

      bookmarks = [
        "file:///home/${config.custom.core.user.name}/Documents Documents"
        "file:///home/${config.custom.core.user.name}/Downloads Downloads"
        "file:///home/${config.custom.core.user.name}/Pictures Pictures"
        "file:///home/${config.custom.core.user.name}/Videos Videos"
      ];
    };

    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };

    custom.hjem.cfg.files = {
      ".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
    };
  };
}
