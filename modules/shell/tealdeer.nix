{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.tealdeer;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.tealdeer.enable = mkEnableOption "Enable tealdeer (tl;dr man)";

  config = mkIf cfg.enable {
 	programs.tealdeer.enable = true;
  };
}
