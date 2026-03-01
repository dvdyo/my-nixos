{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.gammastep;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.gammastep.enable = mkEnableOption "Enable gammastep";

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.gammastep = {
      enable = true;
      settings {
        general = {
          location-provider = "manual";
          temp-day = 5000;
          temp-night = 3200;
        };
        manual = {
          lat = 48.34;
          lon = 39.19;
        };
      };
    };
  };
}
