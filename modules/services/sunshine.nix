{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.custom.services.sunshine;
  inherit (lib) mkEnableOption mkForce mkIf;
in
{
  options.custom.services.sunshine.enable = mkEnableOption "Enable sunshine";
  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
    services.avahi = {
      # The Sunshine module in the current nixpkgs revision still sets the
      # obsolete options. Override them with null to suppress its warnings.
      publish = {
        enable = mkForce null;
        userServices = mkForce null;
      };
      settings.publish = {
        "disable-publishing" = false;
        "disable-user-service-publishing" = false;
        "publish-addresses" = true;
      };
    };
    users.users.${username}.extraGroups = [ "uinput" ];
    services.logind.settings.Login.HandleLidSwitch = "ignore";
  };
}
