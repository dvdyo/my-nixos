{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.editors.helix;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.editors.helix.enable = mkEnableOption "Enable Helix editor";

  config = mkIf cfg.enable {
    # 1. System-wide Install
    environment.systemPackages = [ pkgs.helix ];

    # 2. User Config (Managed via Hjem Rum)
    custom.core.hjem.cfg.rum.programs.helix = {
      enable = true;
      package = null; # Use system package
      settings = {
        theme = mkDefault "gruvbox";
        editor = {
          line-number = "relative";
          cursorline = true;
          color-modes = true;
          idle-timeout = 0;
          bufferline = "multiple";
          true-color = true;
          lsp.display-messages = true;
          statusline = {
            left = [
              "mode"
              "spinner"
            ];
            center = [ "file-name" ];
            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
            ];
            separator = "│";
          };
        };
        keys.normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
      };
    };
  };
}
