{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.networking;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./gns3.nix
    ./wireshark.nix
    ./aircrack-ng.nix
  ];

  options.custom.networking = {
    enable = mkEnableOption "Enable networking suite";
  };

  config = mkIf cfg.enable {
    custom.networking = {
      gns3.enable = mkDefault true;
      wireshark.enable = mkDefault true;
      aircrack-ng.enable = mkDefault true;
    };
  };
}
