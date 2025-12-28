{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.devel.android;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.custom.devel.android.enable = mkEnableOption "Enable Android Dev Environment";

  config = mkIf cfg.enable {
    # 1. Enable ADB (Daemon + udev rules)
    programs.adb.enable = true;
    users.users.dvd.extraGroups = [
      "adbusers"
      "kvm"
    ];

    # 2. Install Android Studio (Manages its own SDK)
    environment.systemPackages = [
      pkgs.android-studio
      pkgs.android-tools # Global adb/fastboot
    ];

    # Note: We do NOT set ANDROID_HOME here.
    # We let Android Studio install the SDK to ~/Android/Sdk imperatively.
    # This avoids read-only filesystem issues with the Device Manager.
  };
}