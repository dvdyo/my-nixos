{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.widgets.kurukubar;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.widgets.kurukubar.enable = mkEnableOption "kurukubar";

  config = mkIf cfg.enable {
        environment.systemPackages = [
        inputs.zaphkiel.packages.${pkgs.system}.kurukurubar
    ];
    };
}
