{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.office;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./libreoffice.nix
    ./onlyoffice.nix
  ];

  options.custom.office = {
    enable = mkEnableOption "Enable Office suite";
  };

  config = mkIf cfg.enable {
    custom.office = {
      libreoffice.enable = mkDefault true;
    };
  };
}
