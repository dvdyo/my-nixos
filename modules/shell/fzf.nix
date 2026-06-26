{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell.fzf;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.fzf.enable = mkEnableOption "Enable fzf";

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.fzf = {
      enable = true;
      integrations.fish.enable = true;
    };
  };
}
