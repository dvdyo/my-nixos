{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.vicinae;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.desktop.components.launchers.vicinae.enable = mkEnableOption "Enable Vicinae Launcher";

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.vicinae ];
    # Register implementation
    # custom.interface.launcher.command = "vicinae toggle";

    # Systemd User Service for vicinae-server
    systemd.user.services.vicinae-server = {
      description = "Vicinae Launcher Daemon";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      # Force PATH to ensure launched apps can find their binaries
      environment.PATH = lib.mkForce "/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin";

      serviceConfig = {
        # Using the absolute path to the binary
        ExecStart = "${pkgs.vicinae}/bin/vicinae server --replace";
        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}
