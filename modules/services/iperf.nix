{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.iperf3;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.iperf3.enable = mkEnableOption "Enable iperf3";
  config = mkIf cfg.enable {
    services.iperf3 = {
      enable = true;
      openFirewall = true;
    };
    networking.firewall.allowedUDPPorts = [ 5201 ];
  };
}
