{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop (Safe Fallback)
  custom.desktop.environments.xfce.enable = false;
  # custom.desktop.components.compositors.niri.enable = true; # Enable later

  # Enable programs
  custom.browsers.zen.enable = true;
  custom.terminals.ghostty.enable = true;

  # Enable Libvirt Host
  custom.virtualization.libvirt.enable = true;

  # Enable Android Debugger Bridge
  custom.services.adb.enable = true;

  # Enable Audio
  custom.services.audio.enable = true;

  # AI & Other Backdoors
  custom.evilBackdoors.gemini-cli.enable = true;
}
