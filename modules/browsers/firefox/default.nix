{ self, lib, config, ... }:
let
  cfg = config.custom.browsers.firefox;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.browsers.firefox.enable = mkEnableOption "Enable firefox";
  config = mkIf cfg.enable {
    features = {
      browser = "firefox";
      pdfs = "firefox";
    };

    environment.systemPackages = [ self.wrappers.firefox.drv ];

    environment.variables.BROWSER = "firefox"; # `man` likes having this
  };
}
