{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./adb.nix
    ./audio.nix
    ./greetd.nix
    ./networkManager.nix
  ];

  options.custom.services = {
    enable = mkEnableOption "Enable Services suite";
  };

  config = mkIf cfg.enable {
    custom.services = {
      adb.enable = mkDefault true;
      audio.enable = mkDefault true;
      greetd.enable = mkDefault true;
      networkManager.enable = mkDefault true;
    };
  };
}
