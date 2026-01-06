{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.fish;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.shell.fish.enable = mkEnableOption "Enable Fish shell";

  config = mkIf cfg.enable {
    # System-wide activation (required for login shell)
    programs.fish.enable = true;

    # User configuration via Hjem Rum
    custom.hjem.cfg.rum.programs.fish = {
      enable = true;
      package = null; # Use system package

      # 1. Abbreviations
      abbrs = {
        lg = "lazygit";
        gd = "git diff";
        ga = "git add .";
        gc = "git commit -am";
        gl = "git log";
        gs = "git status";
        gst = "git stash";
        gsp = "git stash pop";
        gp = "git push";
        gpl = "git pull";
        gsw = "git switch";
        gsm = "git switch main";
        gb = "git branch";
        gbd = "git branch -d";
        gco = "git checkout";
        gsh = "git show";
        l = "ls";
        ll = "ls -l";
        la = "ls -a";
        lla = "ls -la";
        ez = "eza --icons --group-directories-first -1";
      };

      # 2. Aliases (don't work?)
      aliases = {
      };

      # 3. Custom Functions & Config
      functions = {
        fish_greeting = ""; # Disable greeting
      };

      config = ''
        # Custom Functions
        function mark_prompt_start --on-event fish_prompt
            echo -en "\\e]133;A\\e\\\\"
        end
	fish_vi_key_bindings
        
	# Colors
        set -g fish_color_autosuggestion brblack
        set -g fish_color_cancel -r
        set -g fish_color_command normal
        set -g fish_color_comment red
        set -g fish_color_cwd green
        set -g fish_color_cwd_root red
        set -g fish_color_end green
        set -g fish_color_error brred
        set -g fish_color_escape brcyan
        set -g fish_color_history_current --bold
        set -g fish_color_host normal
        set -g fish_color_host_remote yellow
        set -g fish_color_normal normal
        set -g fish_color_operator brcyan
        set -g fish_color_param cyan
        set -g fish_color_quote yellow
        set -g fish_color_redirection cyan --bold
        set -g fish_color_search_match white --background=brblack
        set -g fish_color_selection white --bold --background=brblack
        set -g fish_color_status red
        set -g fish_color_user brgreen
        set -g fish_color_valid_path --underline
      '';
    };
  };
}
