{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.evilBackdoors.gemini-cli;
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  options.custom.evilBackdoors.gemini-cli = {
    enable = mkEnableOption "Enable Gemini CLI";
    projectId = mkOption {
      type = types.str;
      default = "";
      description = "Google Cloud Project ID";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.gemini-cli ];

    environment.sessionVariables = mkIf (cfg.projectId != "") {
      GOOGLE_CLOUD_PROJECT = cfg.projectId;
    };
  };
}
