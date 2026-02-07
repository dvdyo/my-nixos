{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.editors;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./vim.nix
    ./helix.nix
    # ./nvf
  ];

  options.custom.editors = {
    enable = mkEnableOption "Enable Editors suite";
  };

  config = mkIf cfg.enable {
    custom.editors = {
      vim.enable = mkDefault true;
      helix.enable = mkDefault true;
    };
  };
}