{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.fish;
in
{
  options.custom.programs.fish.enable = lib.mkEnableOption "Enable Fish shell";

  config = lib.mkIf cfg.enable {
    # System-wide activation (required for login shell)
    programs.fish.enable = true;

    # User configuration via Hjem Rum
    custom.core.hjem.cfg.rum.programs.fish = {
      enable = true;
      package = null; # Use system package
    };
  };
}