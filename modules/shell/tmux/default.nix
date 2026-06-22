{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.tmux;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.tmux.enable = mkEnableOption "Enable tmux";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
    };
    custom.hjem.cfg.xdg.config.files."tmux/tmux.conf" = {
      source = ./tmux.conf;
    };
    custom.hjem.cfg.xdg.config.files."tmux/tmux.conf.local" = {
      source = ./tmux.conf.local
    };
  };
}
