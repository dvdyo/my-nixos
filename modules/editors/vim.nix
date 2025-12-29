{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.editors.vim;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.editors.vim = {
    enable = mkEnableOption "Enable Vim editor";
    defaultEditor = mkEnableOption "Set Vim as the default system editor";
  };

  config = mkIf cfg.enable {
    programs.vim = {
      enable = true;
      defaultEditor = cfg.defaultEditor;
    };
  };
}
