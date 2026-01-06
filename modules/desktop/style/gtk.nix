{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.style;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.style = {
    enable = mkEnableOption "Enable centralized desktop styling (Catppuccin)";
  };

  config = mkIf cfg.enable {
    # 1. System-wide Theme Packages
    environment.systemPackages = [
      (pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        variant = "mocha";
      })
      (pkgs.catppuccin-papirus-folders.override {
        accent = "blue";
        flavor = "mocha";
      })
      pkgs.bibata-cursors
    ];

    # 2. GTK Configuration via Hjem Rum
    custom.hjem.cfg.rum.misc.gtk = {
      enable = true;
      settings = {
        theme-name = "Catppuccin-Mocha-Standard-Blue-Dark";
        icon-theme-name = "Papirus-Dark";
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

      # Custom CSS for further polish (optional)
      css.gtk3 = ''
        /* Make scrollbars thin and clean */
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

    # 3. Pointer/Cursor Logic (Ensure it works in Wayland)
    # Most Wayland apps respect the GTK setting, but we can set env vars to be sure.
    environment.sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "24";
    };
  };
}
