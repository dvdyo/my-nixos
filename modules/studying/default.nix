{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.studying;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./ciscoPacketTracer.nix
    
  ];

  options.custom.studying = {
    enable = mkEnableOption "Enable studying suite";
  };

  config = mkIf cfg.enable {
    custom.studying = {
      ciscoPacketTracer.enable = mkDefault true;
      anki.enable = mkDefault true;
    };
  };
}
