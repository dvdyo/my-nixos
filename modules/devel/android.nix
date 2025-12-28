{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.custom.devel.android;
  inherit (lib) mkEnableOption mkIf;

  # Define the immutable Android SDK with specific packages
  androidSdk = inputs.android-nixpkgs.sdk.x86_64-linux (sdkPkgs: with sdkPkgs; [
    # Tools
    cmdline-tools-latest
    build-tools-34-0-0
    platform-tools
    emulator

    # Platforms
    platforms-android-34

    # System Images (for Emulator)
    system-images-android-34-google-apis-x86-64
  ]);
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

    # 2. Install Tools
    environment.systemPackages = [
      androidSdk
      pkgs.android-studio
    ];

    # 3. Environment Variables
    environment.sessionVariables = {
      ANDROID_HOME = "${androidSdk}/share/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdk}/share/android-sdk";
    };
  };
}
