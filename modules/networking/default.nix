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
    ./wireshark.nix
  ];

  options.custom.networking = {
    enable = mkEnableOption "Enable networking suite";
  };

  config = mkIf cfg.enable {
    custom.networking = {
      wireshark.enable = mkDefault true;
    };
  };
}
