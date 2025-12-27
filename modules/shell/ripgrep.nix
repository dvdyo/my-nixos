{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.ripgrep;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.ripgrep.enable = mkEnableOption "Enable ripgrep";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
