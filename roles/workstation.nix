{ ... }:
{
  imports = [
    ./base.nix
  ];

  custom = {
    desktop = {
      environments.niri-custom.enable = true;
      components.compositors.xwayland-satellite.enable = true;
      style.enable = true;
      components.fonts.enable = true;
      screencap.enable = true;
      components.wallpapers.awww.enable = true;
      components.polkitAgents.gnome.enable = true;
      components.notifications.mako.enable = true;
    };
    browsers.enable = true;
    terminals.enable = true;
    editors.enable = true;
    virtualization.enable = true;
    services.enable = true;
    office.enable = true;
    studying.enable = true;
    socials.enable = true;
    security.enable = true;
    p2p.enable = true;
    media.enable = true;
    fileManagers.enable = true;
    recording.enable = true;
    sysmons.enable = true;
    gaming.enable = true;
    networking.enable = true;
    notes.enable = true;
    services.openssh.enable = true;
    services.sunshine.enable = true;
    services.freerdp.enable = true;
  };
}
