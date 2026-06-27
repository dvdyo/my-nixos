{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.fileManagers.yazi;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.fileManagers.yazi = {
    enable = mkEnableOption "Enable Yazi File Manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ripdrag ];

    custom.hjem.cfg.rum.programs.yazi = {
      enable = true;

      settings = {
        mgr = {
          show_hidden = false;
          sort_by = "natural";
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
        };
      };

      keymap = {
        mgr.prepend_keymap = [
          {
            on = "<C-n>";
            run = "shell '${lib.getExe pkgs.ripdrag} -a -x \"$@\"' --confirm";
            desc = "Drag and drop via ripdrag";
          }
        ];
      };

      # Leave theme = {} so hjem-rum doesn't generate a theme.toml
    };

    # Directly link our local TOML file 
    custom.hjem.cfg.xdg.config.files."yazi/theme.toml" = {
      source = ./gruvbox-material-dark.toml;
    };
  };
}
