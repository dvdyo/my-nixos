{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.notes.obsidian;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.notes.obsidian.enable = mkEnableOption "Enable obsidian editor";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
      obsidian
    ];
  };
}
