{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.microfetch;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.programs.microfetch.enable = mkEnableOption "Enable microfetch";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.microfetch ];

    # Optional: run on fish start
    programs.fish.interactiveShellInit = mkIf config.custom.programs.fish.enable ''
      ${pkgs.microfetch}/bin/microfetch
    '';
  };
}
