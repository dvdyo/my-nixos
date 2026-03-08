{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.fileManagers;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./yazi
  ];

  options.custom.fileManagers = {
    enable = mkEnableOption "Enable File Managers suite";
  };

  config = mkIf cfg.enable {
    custom.fileManagers = {
      yazi.enable = mkDefault true;
    };
  };
}
