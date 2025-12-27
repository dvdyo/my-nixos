{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.bat;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.bat.enable = mkEnableOption "Enable bat (cat replacement)";

  config = mkIf cfg.enable {
    programs.bat = {
      enable = true;
      settings = {
        theme = "gruvbox-dark";
        italic-text = "always";
      };
    };
  };
}