{
  lib,
  config,
  pkgs,
  username,
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
      default = username;
      description = "Git user name";
    };
    userEmail = mkOption {
      type = str;
      default = "deevidee@proton.me";
      description = "Git user email";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs;
    [
      git
      lazygit
    ];

    custom.hjem.cfg.rum.programs.git = {
      enable = true;
      package = null;
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
