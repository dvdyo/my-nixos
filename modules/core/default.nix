{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.core;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./nix.nix
    ./user.nix
  ];

  options.custom.core = {
    enable = mkEnableOption "Enable Core System Configuration (User, Nix, Boot, Locale)";
  };

  config = mkIf cfg.enable {
    custom.core = {
      boot.enable = mkDefault true;
      locale.enable = mkDefault true;
      nix.enable = mkDefault true;
      user.enable = mkDefault true;
    };
  };
}