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

  profileName = username;
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
        "browser.bookmarks.file" = "/home/${username}/.mozilla/firefox/${username}/bookmarks.html";
        "browser.places.importBookmarksHTML" = true;
      };
      policies =
        (builtins.fromJSON (builtins.readFile ./policies/extensions.json))
        // (builtins.fromJSON (builtins.readFile ./policies/policies.json))
        // (builtins.fromJSON (builtins.readFile ./policies/preferences.json))
        // (builtins.fromJSON (builtins.readFile ./policies/searchEngines.json));
    };

    environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };

    hjem.users.${username}.files = {
      ".mozilla/firefox/${profileName}/chrome/userChrome.css".source = ./userChrome.css;
      ".mozilla/firefox/${profileName}/bookmarks.html".source = ./bookmarks.html;
    };
  };
}
