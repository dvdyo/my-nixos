{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.studying.docling;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.studying.docling.enable = mkEnableOption "Enable docling ";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.docling
    ];
  };
}
