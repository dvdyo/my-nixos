{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.socials.gophertube;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.socials.gophertube = {
    enable = mkEnableOption "Enable gophertube (a client for youtube)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gophertube
    ];
    custom.hjem.cfg.xdg.config.files."gophertube/gophertube.toml" = {
      source = ./gophertube.toml;
    };
  };
}
