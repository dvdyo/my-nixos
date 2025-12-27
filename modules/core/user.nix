{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.core.user;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.core.user = {
    enable = mkEnableOption "Enable main user 'dvd'";
  };

  config = mkIf cfg.enable {
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
      shell = pkgs.fish;
    };
  };
}
