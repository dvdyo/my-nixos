{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.core.boot;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.core.boot.enable = mkEnableOption "Enable Standard UEFI Bootloader (systemd-boot)";

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
