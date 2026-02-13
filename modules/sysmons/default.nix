{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.sysmons;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./bottom.nix
  ];

  options.custom.sysmons = {
    enable = mkEnableOption "Enable default sysmon ";
  };

  config = mkIf cfg.enable {
    custom.sysmons = {
      bottom.enable = mkDefault true;
    };
  };
}
