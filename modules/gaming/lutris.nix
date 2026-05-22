{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.gaming.lutris;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.gaming.lutris.enable = mkEnableOption "Enable lutris";

  config = mkIf cfg.enable {
    openldap = prev.openldap.overrideAttrs {
      doCheck = !prev.stdenv.hostPlatform.isi686;
    };
    environment.systemPackages = [ pkgs.lutris ];
  };
}
