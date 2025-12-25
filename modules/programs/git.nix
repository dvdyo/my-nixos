{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.programs.git;
in
{
  options.custom.programs.git = {
    enable = lib.mkEnableOption "Enable Git";
    userName = lib.mkOption {
      type = lib.types.str;
      default = "dvd";
      description = "Git user name";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "dvd@example.com";
      description = "Git user email";
    };
  };

  config = lib.mkIf cfg.enable {
    # 1. System-wide Install (Available to root and all users)
    environment.systemPackages = [ pkgs.git ];

    # 2. User Config (Managed via Hjem Rum)
    custom.core.hjem.cfg.rum.programs.git = {
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
