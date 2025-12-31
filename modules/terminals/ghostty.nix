{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.terminals.ghostty;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.terminals.ghostty.enable = mkEnableOption "Enable Ghostty Terminal";

  config = mkIf cfg.enable {
    # 1. System-wide Install
    environment.systemPackages = [ pkgs.ghostty ];

    # 2. User Config (Managed via Hjem Rum)
    custom.hjem.cfg.rum.programs.ghostty = {
      enable = true;
      package = null; # Use system package
      settings = {
        theme = mkDefault "Gruvbox Dark";
        font-size = mkDefault 12;
        window-decoration = true;
      };
    };
  };
}
