{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell.zoxide;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.zoxide.enable = mkEnableOption "Enable zoxide";

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.zoxide = {
      enable = true;
      integrations.fish.enable = true;
    };
  };
}
