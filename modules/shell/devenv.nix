{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.devenv;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.devenv.enable = mkEnableOption "Enable devenv";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.devenv ];
  };
}
