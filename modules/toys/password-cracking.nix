{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.toys.password-cracking;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.toys.password-cracking.enable = mkEnableOption "Enable password cracking suite"

  config = mkIf cfg.enable {
    environment.systemPackages =
    [
      pkgs.crunch
      pkgs.hashcat
      pkgs.hashcat-utils
    ];
  };
}
