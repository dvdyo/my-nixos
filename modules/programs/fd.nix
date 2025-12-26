{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.fd;
in
{
  options.custom.programs.fd.enable = lib.mkEnableOption "Enable fd (find replacement)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.fd ];
  };
}
