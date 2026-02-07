{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.desktop.style;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./gtk.nix
  ];

  options.custom.desktop.style = {
    enable = mkEnableOption "Enable Desktop Style suite";
  };

  config = mkIf cfg.enable {
    custom.desktop.style = {
      gtk.enable = mkDefault true;
    };
  };
}