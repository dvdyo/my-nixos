{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.programs.zen;
in
{
  options.custom.programs.zen.enable = lib.mkEnableOption "Enable Zen Browser";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (inputs.zen-browser.packages."${pkgs.system}".default.override {
        policies = {
          AutofillAddressEnabled = true;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          OfferToSaveLogins = false;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };
      })
    ];
  };
}