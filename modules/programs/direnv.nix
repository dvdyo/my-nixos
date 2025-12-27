{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.direnv;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.direnv.enable = mkEnableOption "Enable direnv (with nix-direnv)";

  config = mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.direnv = {
      enable = true;
      integrations = {
        fish.enable = true;
        nix-direnv.enable = true; # Critical for fast flake shells
      };
    };
  };
}
