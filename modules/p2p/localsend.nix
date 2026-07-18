{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.p2p.localsend;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.p2p.localsend = {
    enable = mkEnableOption "Enable localsend";
  };

  config = mkIf cfg.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
