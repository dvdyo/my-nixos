{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.evilBackdoors;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./gemini-cli.nix
  ];

  options.custom.evilBackdoors = {
    enable = mkEnableOption "Enable Evil Backdoors";
  };

  config = mkIf cfg.enable {
    custom.evilBackdoors = {
      gemini-cli.enable = mkDefault true;
    };
  };
}