{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.direnv;
in
{
  options.custom.programs.direnv.enable = lib.mkEnableOption "Enable direnv (with nix-direnv)";

  config = lib.mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.direnv = {
      enable = true;
      integrations = {
        fish.enable = true;
        nix-direnv.enable = true; # Critical for fast flake shells
      };
    };
  };
}
