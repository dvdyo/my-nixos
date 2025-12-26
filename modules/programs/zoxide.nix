{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.zoxide;
in
{
  options.custom.programs.zoxide.enable = lib.mkEnableOption "Enable zoxide";

  config = lib.mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.zoxide = {
      enable = true;
      integrations.fish.enable = true;
    };
  };
}
