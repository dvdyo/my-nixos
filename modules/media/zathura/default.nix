{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.media.zathura;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.media.zathura = {
    enable = mkEnableOption "Enable zathura pdf reader";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.zathura ];

    custom.hjem.cfg.xdg.config.files."zathura/zathurarc" = {
      (builtins.readFile ./zathurarc)
    };

  };
}
