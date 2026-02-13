{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.browsers.ungoogled-chromium;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.browsers.ungoogled-chromium.enable = mkEnableOption "Enable ungoogled-chromium";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ungoogled-chromium ];
  };
}
