{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.hexecute;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.launchers.hexecute.enable =
    mkEnableOption "Enable hexecute Launcher";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
      inputs.hexecute.packages.${pkgs.system}.default
    ];
          
    };
}
