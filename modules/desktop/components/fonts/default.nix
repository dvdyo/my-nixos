{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.fonts;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.custom.desktop.components.fonts.enable = mkEnableOption "Enable Desktop Fonts";

  config = mkIf cfg.enable {
    # Font packages and fontconfig
    fonts = {
      packages = with pkgs; [
        corefonts
        noto-fonts
        cascadia-code
        noto-fonts-color-emoji
        nerd-fonts.jetbrains-mono
      ];
      fontconfig.useEmbeddedBitmaps = true;
      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono NF" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
