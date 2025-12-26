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
      # Optional: default settings
      settings = {
        add_newline = false;
        aws.disabled = true;
        gcloud.disabled = true;
        line_break.disabled = true;
      };
    };
  };
}
