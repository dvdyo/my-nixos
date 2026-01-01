{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.fonts;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.fonts.enable = mkEnableOption "Enable desktop fonts";

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        corefonts # Microsoft free fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
      ];

      # Set default fonts
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
