{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.programs.zen;
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
in
{
  options.custom.programs.zen.enable = lib.mkEnableOption "Enable Zen Browser";

  config = lib.mkIf cfg.enable {
    # 1. Install the vanilla browser package
    environment.systemPackages = [
      inputs.zen-browser.packages."${pkgs.system}".default
    ];

    # 2. Deploy policies to /etc/firefox (standard location)
    environment.etc."firefox/policies/policies.json".text = builtins.toJSON {
      inherit policies;
    };

  };
}
