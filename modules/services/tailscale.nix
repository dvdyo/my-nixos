{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.services.tailscale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.tailscale.enable = mkEnableOption "Enable tailscale";

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
  };
}
