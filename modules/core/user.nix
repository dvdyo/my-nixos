{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.core.user;
in
{
  options.custom.core.user = {
    enable = lib.mkEnableOption "Enable main user 'dvd'";
  };

  config = lib.mkIf cfg.enable {
    users.users.dvd = {
      isNormalUser = true;
      description = "DVD";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "docker"
      ];
      # initialPassword = "password"; # Set in host file or manually
    };
  };
}
