{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.socials;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./vesktop.nix
    ./ayugram.nix
    ./equibop.nix
  ];

  options.custom.socials = {
    enable = mkEnableOption "Enable Socials suite";
  };

  config = mkIf cfg.enable {
    custom.socials = {
      vesktop.enable = mkDefault true;
      ayugram.enable = mkDefault true;
    };
  };
}
