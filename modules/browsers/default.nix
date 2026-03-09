{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.browsers;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./zen
    ./ungoogled-chromium
  ];

  options.custom.browsers = {
    enable = mkEnableOption "Enable Browsers suite";
  };

  config = mkIf cfg.enable {
    custom.browsers = {
      firefox.enable = mkDefault true;
      ungoogled-chromium.enable = mkDefault true;
    };
  };
}
