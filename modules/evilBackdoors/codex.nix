{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.evilBackdoors.codex;
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    ;
in
{
  options.custom.evilBackdoors.codex = {
    enable = mkEnableOption "Enable codex";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.codex ];
  };
}
