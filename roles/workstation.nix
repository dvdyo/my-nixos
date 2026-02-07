{ ... }:
{
  imports = [
    ./base.nix
  ];

  # Enable Desktop
  custom.desktop.environments.niri-custom.enable = true;
  custom.desktop.components.compositors.xwayland-satellite.enable = true;
  custom.desktop.style.enable = true;
  custom.desktop.components.fonts.enable = true;

  # Enable Screenshot Stack
  custom.desktop.screencap.enable = true;

  # Enable programs
  custom.browsers.enable = true;
  custom.terminals.enable = true;
  custom.terminals.ghostty.enable = false;

  # Enable Awww (Wallpaper Daemon)
  custom.desktop.components.wallpapers.awww.enable = true;

  # Enable Polkit Agent (Authentication Dialogs)
  custom.desktop.components.polkitAgents.gnome.enable = true;

  # Enable Notifications
  custom.desktop.components.notifications.mako.enable = true;

  # Editors
  custom.editors.enable = true;
  
  # Enable Virtualization
  custom.virtualization.enable = true;
  custom.virtualization.qemu-guest.enable = false;

  # Enable Services
  custom.services.enable = true;

  # Enable Office
  custom.office.enable = true;

  # Enable Socials
  custom.socials.enable = true;

  # Enable Security
  custom.security.enable = true;

  # Enable P2P
  custom.p2p.enable = true;

  # Enable Gaming
  custom.gaming.enable = true;

  # AI & Other Backdoors
  custom.evilBackdoors.enable = true;
}