{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.gaming;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./steam.nix
  ];

  options.custom.gaming = {
    enable = mkEnableOption "Enable Gaming suite";
  };

  config = mkIf cfg.enable {
    custom.gaming = {
      steam.enable = mkDefault true;
    };
  };
}