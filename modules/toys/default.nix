{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.toys;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [

  ];

  options.custom.toys = {
    enable = mkEnableOption "Enable toys suite";
  };

  config = mkIf cfg.enable {
    custom.toys = {
      network-pentesting.enable = mkDefault true;
    };
  };
}
