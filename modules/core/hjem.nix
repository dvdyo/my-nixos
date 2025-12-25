{
  config,
  lib,
  inputs,
  options,
  ...
}:
let
  cfg = config.custom.core.hjem;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    mkAliasDefinitions
    ;
  inherit (lib.types)
    str
    nullOr
    attrs
    ;
in
{
  imports = [
    inputs.hjem.nixosModules.default
  ];

  options.custom.core.hjem = {
    enable = mkEnableOption "Enable hjem for home management";
    user = mkOption {
      type = nullOr str;
      description = "User to manage via hjem";
      default = "dvd";
    };
    cfg = mkOption {
      type = attrs;
      description = "Shortcut to hjem user attribute set";
      default = { };
    };
  };

  config = mkIf cfg.enable {
    hjem = {
      extraModules = [
        inputs.hjem-rum.hjemModules.default
      ];
      clobberByDefault = true;
      # The "Magic" alias: maps our custom.hjem.cfg to the actual hjem user path
      users.${cfg.user} = mkAliasDefinitions options.custom.core.hjem.cfg;
    };

    # Baseline settings for the user
    custom.core.hjem.cfg = {
      user = cfg.user;
      directory = "/home/${cfg.user}";
    };
  };
}
