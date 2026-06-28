{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.notes;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./obsidian.nix
  ];

  options.custom.notes = {
    enable = mkEnableOption "Enable notes suite";
  };

  config = mkIf cfg.enable {
    custom.notes = {
      obsidian.enable = mkDefault true;
    };
  };
}
