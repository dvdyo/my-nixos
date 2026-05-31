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
#      nixpkgs.overlays = [
#        (final: prev: {
#          openldap = prev.openldap.overrideAttrs (_: {
#            doCheck = false;
#          });
#        })
#      ];
    environment.systemPackages = [ pkgs.lutris ];
  };
}
