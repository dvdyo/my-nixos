{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.gaming.pineconemc;
  pineconemc = inputs.pineconemc.packages.${pkgs.stdenv.hostPlatform.system}.default;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.gaming.pineconemc = {
    enable = mkEnableOption "Enable PineconeMC Minecraft launcher";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pineconemc ];
  };
}
