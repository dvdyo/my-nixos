{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.microfetch;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.microfetch.enable = mkEnableOption "Enable microfetch";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.microfetch ];

    # Optional: run on fish start
    programs.fish.interactiveShellInit = mkIf config.custom.shell.fish.enable ''
      ${lib.getExe microfetch}
    '';
  };
}
