{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.custom.browsers.firefox;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.browsers.firefox.enable = mkEnableOption "Enable Firefox";

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      preferences = {
        "services.sync.declinedEngines" = "";
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
      };

      policies = {
        # --- General ---
       DontCheckDefaultBrowser = true;
       DisableFirefoxScreenshots = true;
       DisableFirefoxStudies = true;
       DisableTelemetry = true;
       DisplayBookmarksToolbar = "never";
       DisplayMenuBar = "never";
       OverrideFirstRunPage = "";
       HardwareAcceleration = true;
       TranslateEnabled = true;
       PromptForDownloadLocation = false;
       PictureInPicture.Enabled = false;
       GenerativeAI.Enabled = false;
       Homepage.StartPage = "previous-session";

        UserMessaging = {
#         SkipOnboarding = true;
#         UrlbarInterventions = false;
        };

        FirefoxSuggest = {
#         ImproveSuggest = false;
#         SponsoredSuggestions = false;
#         WebSuggestions = false;
       };

        EnableTrackingProtection = {
#         Value = true;
#         Cryptomining = true;
#         Fingerprinting = true;
#         EmailTracking = true;
        };

        FirefoxHome = {
 #        Search = true;
 #        TopSites = false;
 #        SponsoredTopSites = false;
 #        Highlights = false;
 #        Pocket = false;
 #        SponsoredPocket = false;
 #        Stories = false;
 #        SponsoredStories = false;
 #        Snippets = false;
        };

        # --- Preferences (about:config) ---
        Preferences = {
  #       "privacy.globalprivacycontrol.enabled" = true;
  #       "media.eme.enabled" = true;
  #       "browser.aboutConfig.showWarning" = false;
  #       "browser.warnOnQuitShortcut" = false;
  #       "browser.link.open_newwindow.override.external" = 7;
  #       "media.webspeech.synth.dont_notify_on_error" = true;
  #       "browser.urlbar.suggest.calculator" = true;
  #       "browser.urlbar.unitConversion.enabled" = true;
  #       "browser.urlbar.trimHttps" = true;
  #       "browser.urlbar.suggest.searches" = true;
  #       "browser.toolbars.bookmarks.visibility" = "never";
  #       "services.sync.engine.tabs" = false;
  #       "media.ffmpeg.vaapi.enabled" = true;
  #       "layers.acceleration.force-enabled" = true;
  #       "gfx.webrender.all" = true;
  #       "browser.in-content.dark-mode" = true;
  #       "ui.systemUsesDarkTheme" = true;
  #       "widget.use-xdg-desktop-portal.file-picker" = 1;
  #       "extensions.autoDisableScopes" = 0;
  #       "extensions.update.enabled" = false;
        };

        # --- Extensions ---
        ExtensionSettings = {
#          "*".installation_mode = "blocked";
#          "uBlock0@raymondhill.net".installation_mode = "force_installed";
#          "uBlock0@raymondhill.net".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/ublock-origin/latest.xpi";
#          "addon@darkreader.org".installation_mode = "force_installed";
#          "addon@darkreader.org".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/darkreader/latest.xpi";
#          "gdpr@cavi.au.dk".installation_mode = "force_installed";
#          "gdpr@cavi.au.dk".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/consent-o-matic/latest.xpi";
#          "sponsorBlocker@ajay.app".installation_mode = "force_installed";
#          "sponsorBlocker@ajay.app".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/sponsorblock/latest.xpi";
#          "redirector@einaregilsson.com".installation_mode = "force_installed";
#          "redirector@einaregilsson.com".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/redirector/latest.xpi";
#          "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack".installation_mode = "force_installed";
#          "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/terms-of-service-didnt-read/latest.xpi";
#          "{6d85dea2-0fb4-4de3-9f8c-264bce9a2296}".installation_mode = "force_installed";
#          "{6d85dea2-0fb4-4de3-9f8c-264bce9a2296}".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/link-cleaner/latest.xpi";
#          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".installation_mode = "force_installed";
#          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
#          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".installation_mode = "force_installed";
#          "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/refined-github-/latest.xpi";
#          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".installation_mode = "force_installed";
#          "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/auto-tab-discard/latest.xpi";
#          "{cb31ec5d-c49a-4e5a-b240-16c767444f62}".installation_mode = "force_installed";
#          "{cb31ec5d-c49a-4e5a-b240-16c767444f62}".install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/indie-wiki-buddy/latest.xpi";
        };


        # --- Search Engines ---
        SearchEngines = {
          Default = "Google (udm14)";
          Remove = [ "DuckDuckGo" "Bing" "eBay" "Amazon.com" "Wikipedia (en)" "Google" "Perplexity" ];
          Add = [
            { Name = "Google (udm14)"; IconURL = "https://www.google.com/favicon.ico"; URLTemplate = "https://www.google.com/search?q={searchTerms}&udm=14"; }
            { Name = "Noogle"; Alias = "@ng"; IconURL = "https://noogle.dev/favicon.png"; URLTemplate = "https://noogle.dev/q?term={searchTerms}"; }
            { Name = "Nixpkgs"; Alias = "@npkgs"; URLTemplate = "https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+{searchTerms}"; }
            { Name = "NixOS Options"; Alias = "@on"; URLTemplate = "https://search.nixos.org/options?channel=unstable&from=0&size=100&sort=alpha_asc&query={searchTerms}"; }
            { Name = "Home Manager"; Alias = "@hmgr"; URLTemplate = "https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+{searchTerms}"; }
            { Name = "Home Manager Options"; Alias = "@oh"; IconURL = "https://home-manager-options.extranix.com/images/favicon.png"; URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}"; }
            { Name = "Github Search"; Alias = "@gh"; IconURL = "https://github.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=NOT+is:fork+{searchTerms}"; }
            { Name = "Github Search Nix"; Alias = "@gn"; IconURL = "https://github.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=lang:nix+NOT+is:fork+{searchTerms}"; }
            { Name = "Github Search Fish"; Alias = "@gf"; IconURL = "https://fishshell.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=lang:fish+NOT+is:fork+{searchTerms}"; }
            { Name = "Github Search Lua"; Alias = "@gl"; IconURL = "https://github.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=lang:lua+NOT+is:fork+{searchTerms}"; }
            { Name = "Github Search Gleam"; Alias = "@gg"; IconURL = "https://github.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=lang:gleam+NOT+is:fork+{searchTerms}"; }
            { Name = "Github Search Typst"; Alias = "@gt"; IconURL = "https://github.com/favicon.ico"; URLTemplate = "https://github.com/search?type=code&q=lang:typst+NOT+is:fork+{searchTerms}"; }
          ];
        };
      };
    };

#    environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";

    hjem.users.${username}.files = {
      ".mozilla/firefox/${username}/chrome/userChrome.css".source = ./userChrome.css;
      ".mozilla/firefox/${username}/bookmarks.html".source = ./bookmarks.html;
    };
  };
}
