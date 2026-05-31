{
  lib,
  config,
  pkgs,
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
      autoStart = true;
      capSysAdmin = true;
      openFirewall = false;
      applications = {
        apps = [
          {
            name = "Umineko";
            command = "steam-run /home/dvd/Games/Umineko/onscripter-ru";
          }
        ];
      };
    };
    users.users.${username}.extraGroups = [ "uinput" ];
  };
}
