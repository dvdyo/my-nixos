{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.socials.telegram;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.socials.telegram = {
    enable = mkEnableOption "Enable Telegram (Ayugram Client)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      # Using Ayugram (Ghost Mode client) from Nixpkgs
      pkgs.ayugram-desktop
    ];
  };
}
