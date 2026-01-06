{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.security.keepassxc;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.security.keepassxc = {
    enable = mkEnableOption "Enable KeePassXC Password Manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      pkgs.keepassxc
    ];
  };
}
