{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell.starship;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.starship.enable = mkEnableOption "Enable starship prompt";

  config = mkIf cfg.enable {
    custom.hjem.cfg.rum.programs.starship = {
      enable = true;
      integrations.fish.enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };
}