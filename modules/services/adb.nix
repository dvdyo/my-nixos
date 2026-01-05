{
  lib,
  config,
  ...
}:
let
  cfg = config.custom.services.adb;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.services.adb.enable =
    mkEnableOption "Enable Android System Prerequisites (KVM + ADB)";

  config = mkIf cfg.enable {
    # Prerequisite 1: ADB Daemon and Udev rules
    programs.adb.enable = true;

    # Prerequisite 2: User groups for ADB
    users.users.${config.custom.core.user.name}.extraGroups = [
      "adbusers"
    ];
  };
}
