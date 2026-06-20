{
  lib,
  config,
  pkgs,
  username,
  ...
}:
let
  cfg = config.custom.networking.wireshark;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.networking.wireshark.enable = mkEnableOption "Enable wireshark";

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      usbmon.enable = true;
    };
    users.users.${username}.extraGroups = [
      "wireshark"
    ];

  };
}
