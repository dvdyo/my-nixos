{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  # custom.desktop.xfce.enable = false;
  custom.desktop.environments.niri-custom.enable = true;
  custom.desktop.style.enable = true;
  custom.desktop.components.fonts.enable = true;

  # Enable programs
  custom.browsers.zen.enable = true;
  custom.terminals.ghostty.enable = false;
  # Enable Awww (Wallpaper Daemon)
  custom.desktop.components.wallpapers.awww.enable = true;

  # Enable Polkit Agent (Authentication Dialogs)
  custom.desktop.components.polkitAgents.gnome.enable = true;

  # Enable Notifications
  custom.desktop.components.notifications.mako.enable = true;

  # Editors
  custom.editors.helix.enable = true;
  
  # Enable Foot Terminal
  custom.terminals.foot.enable = true;
  
  # Enable Libvirt Host
  custom.virtualization.libvirt.enable = true;

  # Enable Android Debugger Bridge
  custom.services.adb.enable = true;

  # Enable Office
  custom.office.libreoffice.enable = true;

  # Enable Socials
  custom.socials.vesktop.enable = true;
  custom.socials.ayugram.enable = true;

  # Enable Security
  custom.security.keepassxc.enable = true;

  # Enable Audio
  custom.services.audio.enable = true;

  # Enable Display Manager
  custom.services.greetd.enable = true;

  # AI & Other Backdoors
  custom.evilBackdoors.gemini-cli.enable = true;
}
