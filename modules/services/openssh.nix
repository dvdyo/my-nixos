{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.openssh;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.openssh.enable = mkEnableOption "Enable openssh";
  config = mkIf cfg.enable {
    services.sshguard.enable = true;
    services.openssh = {
      enable = true;
      startWhenNeeded = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
