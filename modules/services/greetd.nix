{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.services.greetd;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.greetd.enable = mkEnableOption "Enable Greetd Display Manager";

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      # Optimized for TUI greeters (TTY handling)
      useTextGreeter = true;
      
      settings = {
        default_session = {
          # --time: shows clock
          # --remember: remembers last user
          # --remember-session: remembers last session (niri vs bash)
          # --sessions: Path to session desktop files
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions /run/current-system/sw/share/wayland-sessions";
          user = "greeter";
        };
      };
    };
  };
}
