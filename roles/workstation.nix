{ ... }:
{
  imports = [
    ./base.nix
  ];

  custom.desktop.environments.niri-custom.enable = true;
  custom.desktop.components.compositors.xwayland-satellite.enable = true;
  custom.desktop.style.enable = true;
  custom.desktop.components.fonts.enable = true;

  custom.desktop.screencap.enable = true;

  custom.browsers.enable = true;
  custom.terminals.enable = true;
  custom.terminals.ghostty.enable = false;

  custom.desktop.components.wallpapers.awww.enable = true;

  custom.desktop.components.polkitAgents.gnome.enable = true;

  custom.desktop.components.notifications.mako.enable = true;

  custom.editors.enable = true;
  
  custom.virtualization.enable = true;
  custom.virtualization.qemu-guest.enable = false;

  custom.services.enable = true;

  custom.office.enable = true;

  custom.studying.enable = true;

  custom.socials.enable = true;

  custom.security.enable = true;

  custom.p2p.enable = true;

  custom.media.enable = true;

  custom.fileManagers.enable = true;

  custom.recording.enable = true;

  custom.sysmons.enable = true;
  
  custom.evilBackdoors.enable = true;

  custom.gaming.enable = true;

  custom.networking.enable = true;

  custom.toys.enable = true;
}
