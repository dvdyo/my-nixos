{
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.custom.services.networkManager;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.networkManager = {
    enable = mkEnableOption "Enable NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.backend = "iwd";
    };

    # Enable systemd-resolved for DNS caching and better integration
    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
    };

    # Add user to the group automatically using the global username arg
    users.users.${username}.extraGroups = [ "networkmanager" ];

    # Disable wait-online to speed up boot times
    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
