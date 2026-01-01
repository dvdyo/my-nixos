{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.desktop.components.shells.dms;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.desktop.components.shells.dms.enable = mkEnableOption "Enable Dank Material Shell (DMS)";

  config = mkIf cfg.enable {
    programs.dms-shell = {
      enable = true;

      # Use bleeding-edge quickshell from git
      quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      # Core features
      enableSystemMonitoring = true;
      enableClipboard = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
  };
}
