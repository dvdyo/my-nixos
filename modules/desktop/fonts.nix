{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.fonts;
in
{
  options.custom.desktop.fonts.enable = lib.mkEnableOption "Enable desktop fonts";

  config = lib.mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        corefonts # Microsoft free fonts
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
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
