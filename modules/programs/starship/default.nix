{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.starship;
in
{
  options.custom.programs.starship.enable = lib.mkEnableOption "Enable starship prompt";

  config = lib.mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.starship = {
      enable = true;
      integrations.fish.enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };
}