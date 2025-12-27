{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell.nh;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.nh.enable = mkEnableOption "Enable nh (Nix Helper)";

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      # flake = "/home/dvd/nixos";
    };
  };
}
