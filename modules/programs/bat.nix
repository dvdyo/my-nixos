{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.bat;
in
{
  options.custom.programs.bat.enable = lib.mkEnableOption "Enable bat (cat replacement)";

  config = lib.mkIf cfg.enable {
    programs.bat = {
      enable = true;
      settings = {
        theme = "gruvbox-dark";
        italic-text = "always";
      };
    };
  };
}