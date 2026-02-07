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
  ];

  options.custom.browsers = {
    enable = mkEnableOption "Enable Browsers suite";
  };

  config = mkIf cfg.enable {
    custom.browsers = {
      zen.enable = mkDefault true;
    };
  };
}