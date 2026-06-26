{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.media.zatura;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.media.zatura = {
    enable = mkEnableOption "Enable zatura pdf reader";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.zathura ];

  };
}
