{
  lib,
  config,
  pkgs,
  username,
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
    # Systemd 258+ handles uaccess rules automatically. 
    # We just need the tools and the group for some legacy software.
    environment.systemPackages = [ pkgs.android-tools ];

    # User groups for ADB
    users.users.${username}.extraGroups = [
      "adbusers"
    ];
  };
}
