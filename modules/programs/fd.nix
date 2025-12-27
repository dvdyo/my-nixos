{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.fd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.fd.enable = mkEnableOption "Enable fd (find replacement)";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fd ];
  };
}
