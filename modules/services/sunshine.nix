{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.custom.services.sunshine;
  inherit (lib) mkEnableOption mkIf;
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
    users.users.${username}.extraGroups = [ "uinput" ];
    services.logind.settings.Login.HandleLidSwitch = "ignore";
  };
}
