{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.git;
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str;
in
{
  options.custom.git = {
    enable = mkEnableOption "Enable Git";
    userName = mkOption {
      type = str;
      default = "dvd";
      description = "Git user name";
    };
    userEmail = mkOption {
      type = str;
      default = "dvd@example.com";
      description = "Git user email";
    };
  };

  config = mkIf cfg.enable {
    # 1. System-wide Install (Available to root and all users)
    environment.systemPackages = [ pkgs.git ];

    # 2. User Config (Managed via Hjem Rum)
    custom.hjem.cfg.rum.programs.git = {
      enable = true;
      package = null; # Prevent double installation in user profile
      settings = {
        user = {
          name = cfg.userName;
          email = cfg.userEmail;
        };
        init.defaultBranch = "main";
        pull.rebase = true;
      };
    };
  };
}
