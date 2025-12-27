{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.zoxide;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.zoxide.enable = mkEnableOption "Enable zoxide";

  config = mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.zoxide = {
      enable = true;
      integrations.fish.enable = true;
    };
  };
}
