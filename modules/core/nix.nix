{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.custom.core.nix;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.custom.core.nix.enable = mkEnableOption "Enable Standard Nix Settings";

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = mkDefault true;

    nix =
      let
        flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      in
      {
        settings = {
          experimental-features = "nix-command flakes";
          trusted-users = [ "@wheel" ];
          # Optimization: make flake commands faster by using local pins
          flake-registry = "";
        };

        # Match registry and nix-path to our flake inputs
        registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

        optimise.automatic = true;
      };
  };
}