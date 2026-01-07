{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.socials.vesktop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.socials.vesktop = {
    enable = mkEnableOption "Enable Vesktop (a client for Discord)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      pkgs.vesktop
	];
  };
}
