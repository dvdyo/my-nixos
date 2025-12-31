{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell.direnv;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.direnv.enable = mkEnableOption "Enable direnv (with nix-direnv)";

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.direnv = {
      enable = true;
      integrations = {
        fish.enable = true;
        nix-direnv.enable = true; # Critical for fast flake shells
      };
    };
  };
}
