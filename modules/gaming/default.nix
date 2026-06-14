{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.gaming;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./pineconemc.nix
    ./steam.nix
    ./lutris.nix
    ./rimsort.nix
  ];

  options.custom.gaming = {
    enable = mkEnableOption "Enable Gaming suite";
  };

  config = mkIf cfg.enable {
    custom.gaming = {
      pineconemc.enable = mkDefault true;
      steam.enable = mkDefault true;
      lutris.enable = mkDefault true;
      rimsort.enable = mkDefault false;
    };
  };
}
