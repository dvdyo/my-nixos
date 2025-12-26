{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.microfetch;
in
{
  options.custom.programs.microfetch.enable = lib.mkEnableOption "Enable microfetch";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.microfetch ];

    # Optional: run on fish start
    programs.fish.interactiveShellInit = lib.mkIf config.custom.programs.fish.enable ''
      ${pkgs.microfetch}/bin/microfetch
    '';
  };
}
