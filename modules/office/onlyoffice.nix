{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.office.onlyoffice;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.office.onlyoffice = {
    enable = mkEnableOption "Enable onlyoffice ";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.onlyoffice-desktopeditors
    ];
  };
}
