{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.fd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.fd.enable = mkEnableOption "Enable fd (find replacement)";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fd ];
  };
}
