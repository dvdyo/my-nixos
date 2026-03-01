{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.audio;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.gammastep.enable = mkEnableOption "Enable gammastep";

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = "geoclue2"; # for dynamic location finding
      temperature = {
        day = 6500;
        night = 3200;
      };
    };
  };
}
