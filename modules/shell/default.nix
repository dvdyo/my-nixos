{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.shell;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./fish.nix
    ./microfetch.nix
    ./nh.nix
    ./ripgrep.nix
    ./starship
    ./zoxide.nix
    ./tealdeer.nix
  ];

  options.custom.shell = {
    enable = mkEnableOption "Enable full shell suite";
  };

  config = mkIf cfg.enable {
    custom.shell = {
      fish.enable = mkDefault true;
      starship.enable = mkDefault true;
      bat.enable = mkDefault true;
      eza.enable = mkDefault true;
      fd.enable = mkDefault true;
      ripgrep.enable = mkDefault true;
      zoxide.enable = mkDefault true;
      direnv.enable = mkDefault true;
      microfetch.enable = mkDefault true;
      nh.enable = mkDefault true;
      tealdeer.enable = mkDefault true;
    };
  };
}
