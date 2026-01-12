{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.core.user;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.core.user = {
    enable = mkEnableOption "Enable main user";
    name = lib.mkOption {
      type = lib.types.str;
      default = "dvd";
      description = "The username of the main user";
    };
  };

  config = mkIf cfg.enable {
    _module.args.username = cfg.name;

    users.users.${cfg.name} = {
      isNormalUser = true;
      description = "DVD";
      extraGroups = [
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
