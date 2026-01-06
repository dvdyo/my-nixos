{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.socials.equibop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.socials.equibop = {
    enable = mkEnableOption "Enable Equibop (a client for Discord)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      # Equibop (A client for discord, fork of vesktop) 
      pkgs.equibop
	];
  };
}
