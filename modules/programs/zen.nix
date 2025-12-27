{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.programs.zen;
  inherit (lib) mkEnableOption mkIf;
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
  options.custom.programs.zen.enable = mkEnableOption "Enable Zen Browser";

  config = mkIf cfg.enable {
    # 1. Install the vanilla browser package
    environment.systemPackages = [
      inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];

    # 2. Deploy to proper location
    environment.etc."zen/policies/policies.json".text = builtins.toJSON {
      inherit policies;
    };
  };
}
