{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.programs.zen;
in
{
  options.custom.programs.zen.enable = lib.mkEnableOption "Enable Zen Browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];
  };
}
