{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.security;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./keepassxc.nix
  ];

  options.custom.security = {
    enable = mkEnableOption "Enable Security suite";
  };

  config = mkIf cfg.enable {
    custom.security = {
      keepassxc.enable = mkDefault true;
    };
  };
}