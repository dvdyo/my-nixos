{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.socials.ayugram;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.socials.ayugram = {
    enable = mkEnableOption "Enable Telegram (Ayugram Client)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ 
      # Using Ayugram (Ghost Mode client) from Nixpkgs
      pkgs.ayugram-desktop
    ];
  };
}
