{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.chafa;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.chafa.enable = mkEnableOption "Enable chafa";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.chafa ];
  };
}
