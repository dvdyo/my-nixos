{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.rofimoji;
  inherit (lib) mkEnableOption mkIf ;

in
{
  options.custom.desktop.components.launchers.dmenus.rofimoji.enable =
    mkEnableOption "rofimoji enable";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;[
      rofimoji
    ];

  };
}
