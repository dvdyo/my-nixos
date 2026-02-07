{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.desktop.screencap;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./grim.nix
    ./slurp.nix
    ./satty.nix
  ];

  options.custom.desktop.screencap = {
    enable = mkEnableOption "Enable Screenshot suite";
  };

  config = mkIf cfg.enable {
    custom.desktop.screencap = {
      grim.enable = mkDefault true;
      slurp.enable = mkDefault true;
      satty.enable = mkDefault true;
    };
  };
}