{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.tree;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.tree.enable = mkEnableOption "Enable tree";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.tree ];
  };
}
