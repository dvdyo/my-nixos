{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.studying.anki;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.studying.anki.enable = mkEnableOption "Enable anki ";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.anki ];
  };
}
