{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.services.freerdp;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.freerdp.enable =
    mkEnableOption "rdp client";
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.freerdp ];

  };
}
