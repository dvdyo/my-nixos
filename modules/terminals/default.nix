{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.terminals;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  imports = [
    ./ghostty.nix
    ./foot.nix
  ];

  options.custom.terminals = {
    enable = mkEnableOption "Enable Terminals suite";
  };

  config = mkIf cfg.enable {
    custom.terminals = {
      ghostty.enable = mkDefault false;
      foot.enable = mkDefault true;
    };
  };
}
