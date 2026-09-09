{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.custom.desktop.style.gtk;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.style.gtk = {
    enable = mkEnableOption "Enable centralized desktop styling (Gruvbox)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gruvbox-dark-gtk
      pkgs.gruvbox-plus-icons
      pkgs.bibata-cursors
      pkgs.phinger-cursors
    ];

    custom.hjem.cfg.rum.misc.gtk = {
      enable = true;

    settings = {
      theme-name = "gruvbox-dark:dark";
      icon-theme-name = "Gruvbox-Plus-Dark";

      cursor-theme-name = "phinger-cursors-dark";
      cursor-theme-size = 24;

      font-name = "JetBrainsMono Nerd Font 11";

      application-prefer-dark-theme = true;

      enable-event-sounds = 0;
      enable-input-feedback-sounds = 0;

      xft-antialias = 1;
      xft-hinting = 1;
      xft-hintstyle = "hintslight";
      xft-rgba = "rgb";
    };
      # ----------------------------------------------------------------------
      # GTK3
      # ----------------------------------------------------------------------
      #
      # The actual gruvbox-dark package provides gtk-3.0 and gtk-3.20 themes,
      # so GTK3 applications get the complete upstream theme.
      #
      css.gtk3 = ''
        scrollbar {
          -GtkScrollbar-has-backward-stepper: 0;
          -GtkScrollbar-has-forward-stepper: 0;
        }
      '';

      # ----------------------------------------------------------------------
      # GTK4 / libadwaita
      # ----------------------------------------------------------------------
      #
      # gruvbox-dark-gtk does NOT contain a gtk-4.0 theme, so GTK4 cannot use
      # it as a conventional theme. Instead, override GTK4/libadwaita colors
      # through the per-user gtk.css.
      #
      css.gtk4 = ''
        /* ==================================================================
         * Gruvbox Material Dark
         * GTK4 / libadwaita color overrides
         * ================================================================== */

        /* Accent */
        @define-color accent_color #e78a4e;
        @define-color accent_bg_color #e78a4e;
        @define-color accent_fg_color #1d2021;

        /* Destructive */
        @define-color destructive_color #ea698c;
        @define-color destructive_bg_color #ea698c;
        @define-color destructive_fg_color #1d2021;

        /* Success */
        @define-color success_color #a9b665;
        @define-color success_bg_color #a9b665;
        @define-color success_fg_color #1d2021;

        /* Warning */
        @define-color warning_color #d8a657;
        @define-color warning_bg_color #d8a657;
        @define-color warning_fg_color #1d2021;

        /* Error */
        @define-color error_color #ea698c;
        @define-color error_bg_color #ea698c;
        @define-color error_fg_color #1d2021;

        /* ==================================================================
         * Window / View
         * ================================================================== */

        @define-color window_bg_color #282828;
        @define-color window_fg_color #ddc7a1;

        @define-color view_bg_color #1d2021;
        @define-color view_fg_color #ddc7a1;

        /* ==================================================================
         * Headerbar
         * ================================================================== */

        @define-color headerbar_bg_color #282828;
        @define-color headerbar_fg_color #ddc7a1;
        @define-color headerbar_border_color #3c3836;
        @define-color headerbar_backdrop_color #282828;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);

        /* ==================================================================
         * Sidebar
         * ================================================================== */

        @define-color sidebar_bg_color #1d2021;
        @define-color sidebar_fg_color #ddc7a1;
        @define-color sidebar_backdrop_color #1d2021;

        /* ==================================================================
         * Cards
         * ================================================================== */

        @define-color card_bg_color #32302f;
        @define-color card_fg_color #ddc7a1;
        @define-color card_border_color #3c3836;

        /* ==================================================================
         * Dialogs
         * ================================================================== */

        @define-color dialog_bg_color #282828;
        @define-color dialog_fg_color #ddc7a1;

        /* ==================================================================
         * Popovers / Menus
         * ================================================================== */

        @define-color popover_bg_color #32302f;
        @define-color popover_fg_color #ddc7a1;

        /* ==================================================================
         * Miscellaneous
         * ================================================================== */

        @define-color shade_color rgba(0, 0, 0, 0.36);
        @define-color scrollbar_outline_color rgba(0, 0, 0, 0.5);
      '';

      bookmarks = [
        "file:///home/${config.custom.core.user.name}/Documents Documents"
        "file:///home/${config.custom.core.user.name}/Downloads Downloads"
        "file:///home/${config.custom.core.user.name}/Pictures Pictures"
        "file:///home/${config.custom.core.user.name}/Videos Videos"
      ];
    };

    # ------------------------------------------------------------------------
    # Session environment
    # ------------------------------------------------------------------------
    environment.sessionVariables = {
      XCURSOR_THEME = "phinger-cursors-dark";
      XCURSOR_SIZE = "24";

      # LibreOffice VCL backend.
      # This affects LibreOffice, not GTK4 in general.
      SAL_USE_VCLPLUGIN = "gtk3";
    };
  };
}
