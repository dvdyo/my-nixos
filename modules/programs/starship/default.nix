{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.programs.starship;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.starship.enable = mkEnableOption "Enable starship prompt";

  config = mkIf cfg.enable {
    custom.core.hjem.cfg.rum.programs.starship = {
      enable = true;
      integrations.fish.enable = true;
      settings = builtins.fromTOML (builtins.readFile ./starship.toml);
    };
  };
}