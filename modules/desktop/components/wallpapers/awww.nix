{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.wallpapers.awww;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.wallpapers.awww.enable = mkEnableOption "Enable awww wallpaper daemon";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];
  };
}
