{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.ripgrep;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.ripgrep.enable = mkEnableOption "Enable ripgrep";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
