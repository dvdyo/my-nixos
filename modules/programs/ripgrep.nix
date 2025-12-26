{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.ripgrep;
in
{
  options.custom.programs.ripgrep.enable = lib.mkEnableOption "Enable ripgrep";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
