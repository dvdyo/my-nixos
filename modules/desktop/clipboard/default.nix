{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.desktop.clipboard;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./clipsuite.nix
  ];

  options.custom.desktop.clipboard= {
    enable = mkEnableOption "Enable clipboardsuite";
  };

  config = mkIf cfg.enable {
    custom.desktop.clipboard = {
      clipsuite.enable = mkDefault true;
    };
  };
}
