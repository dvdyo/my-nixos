{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.evilBackdoors.gemini-cli;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.evilBackdoors.gemini-cli.enable = mkEnableOption "Enable Gemini CLI";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gemini-cli ];
  };
}
