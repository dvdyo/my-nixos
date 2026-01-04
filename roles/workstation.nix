{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  # custom.desktop.xfce.enable = false;
  custom.desktop.environments.niri-custom.enable = true;
  custom.desktop.components.fonts.enable = true;

  # Enable programs
  custom.browsers.zen.enable = true;
  custom.terminals.ghostty.enable = true;
  custom.terminals.foot.enable = true;

  # Enable Libvirt Host
  custom.virtualization.libvirt.enable = true;

  # Enable Android Debugger Bridge
  custom.services.adb.enable = true;

  # Enable Audio
  custom.services.audio.enable = true;

  # Enable Display Manager
  custom.services.greetd.enable = true;

  # AI & Other Backdoors
  custom.evilBackdoors.gemini-cli.enable = true;
}
