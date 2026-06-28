{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.shell.chafa;
  inherit (lib) mkEnableOption mkIf;
  chafa-webp = pkgs.chafa.overrideAttrs (old: {
  buildInputs = old.buildInputs ++ [ pkgs.libwebp ];
  });
in
{
  options.custom.shell.chafa.enable = mkEnableOption "Enable chafa";

  config = mkIf cfg.enable {
    environment.systemPackages = [ chafa-webp ];
    
  };
}
