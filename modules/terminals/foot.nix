{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.terminals.foot;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.terminals.foot.enable = mkEnableOption "Enable Foot Terminal";

  config = mkIf cfg.enable {
    # 1. System Packages (Manual install since we aren't using programs.foot system module)
    environment.systemPackages = [ pkgs.foot ];

    # 2. Enable Hjem Rum Foot module (Provides User Config)
    custom.hjem.cfg.rum.programs.foot = {
      enable = true;
      package = null; # Use system package
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:size=11";
          term = "xterm-256color";
          pad = "12x12";
          letter-spacing = "0.5"; 
        };
        csd = {
          preferred = "none";
        };
        mouse = {
          hide-when-typing = "yes";
        };
        colors = {
          alpha = 0.95;
          
          # Gruvbox Material Dark (Medium)
          background = "292828";
          foreground = "d4be98";

          # Normal colors
          regular0 = "32302f";  # black
          regular1 = "ea6962";  # red
          regular2 = "a9b665";  # green
          regular3 = "d8a657";  # yellow
          regular4 = "7daea3";  # blue
          regular5 = "d3869b";  # magenta
          regular6 = "89b482";  # cyan
          regular7 = "d4be98";  # white

          # Bright colors
          bright0 = "5a524c";   # bright black
          bright1 = "ea6962";   # bright red
          bright2 = "a9b665";   # bright green
          bright3 = "d8a657";   # bright yellow
          bright4 = "7daea3";   # bright blue
          bright5 = "d3869b";   # bright magenta
          bright6 = "89b482";   # bright cyan
          bright7 = "e2cca9";   # bright white

          # Misc UI colors (Quoted because of the hyphen)
          "selection-foreground" = "d4be98";
          "selection-background" = "504945";
          urls = "d8a657";
        };
      };
    };    
    # 3. Systemd User Service for foot-server
    systemd.user.services.foot-server = {
      description = "Foot Terminal Server";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      # NOTE: We explicitly force the PATH here because NixOS's systemd.user.services
      # logic automatically injects a minimal PATH (coreutils only) into the unit file.
      # Since foot-server's purpose is to spawn user shells, it must have access to 
      # the full system and user binary paths to avoid breaking shell initialization.
      environment.PATH = lib.mkForce "/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin";

      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.foot} --server";
        Restart = "always";
        RestartSec = "1s";
      };
    };
  };
}
