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
    enable = mkEnableOption "Enable Vesktop (Discord Client)";
  };

  config = mkIf cfg.enable {
   programs.vesktop.enable = true;
  };
}
