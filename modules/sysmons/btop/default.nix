{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.sysmons.btop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.sysmons.btop.enable = mkEnableOption "Enable btop sysmon";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.btop-cuda ];
  };
  custom.hjem.cfg.xdg.config.files."btop/btop.conf" = {
    source = ./btop.conf;
  };
  custom.hjem.cfg.xdg.config.files."btop/themes/gruvbox_material_dark.theme"= {
    source = ./gruvbox_material_dark.theme;
  };
}
