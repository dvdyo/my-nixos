{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.fileManagers.yazi;
  inherit (lib) mkEnableOption mkIf;

  gruvbox-material-flavor = pkgs.fetchFromGitHub {
    owner = "dangooddd";
    repo = "gruvbox-material.yazi";
    rev = "main"; # pin to a specific commit hash for reproducibility
    hash = lib.fakeHash; 
  };
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
          show_hidden = true;
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

      # Tell yazi which flavor to use
      theme = {
        flavor = {
          dark = "gruvbox-material";
          light = "gruvbox-material";
        };
      };
    };

    # Drop the flavor files into the flavors directory
    custom.hjem.cfg.xdg.config.files = {
      "yazi/flavors/gruvbox-material.yazi" = {
        source = gruvbox-material-flavor;
      };
    };
  };
}
