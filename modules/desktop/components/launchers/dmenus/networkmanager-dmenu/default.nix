{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.desktop.components.launchers.dmenus.networkmanagerDmenu;
  inherit (lib) mkEnableOption mkIf;

  pythonEnv = pkgs.python3.withPackages (ps: [ ps.pygobject3 ]);

  networkmanagerDmenu = pkgs.stdenv.mkDerivation {
    pname = "networkmanager-dmenu";
    version = "unstable";
    dontBuild = true;
    src = ./.;
    nativeBuildInputs = [ pkgs.python3Packages.wrapPython ];
    buildInputs = [
      pkgs.glib
      pkgs.gobject-introspection
      pkgs.networkmanager
      pythonEnv
    ];
    installPhase = ''
      mkdir -p $out/bin
      cp networkmanager_dmenu $out/bin/
      chmod +x $out/bin/networkmanager_dmenu
      patchShebangs $out/bin/networkmanager_dmenu
    '';
    postFixup = ''
      makeWrapperArgs="\
        --prefix GI_TYPELIB_PATH : ${pkgs.lib.makeSearchPath "lib/girepository-1.0" [
          pkgs.glib
          pkgs.networkmanager
        ]} \
        --prefix PATH : ${lib.makeBinPath [ pkgs.dmenu pkgs.fuzzel pkgs.libnotify ]}"
      wrapPythonPrograms
    '';
  };

  nmDmenuDesktopItem = pkgs.makeDesktopItem {
    name = "networkmanager-dmenu";
    desktopName = "NetworkManager Dmenu";
    genericName = "Networkmanager Settings";
    comment = "Manage NetworkManager connections with dmenu/rofi/wofi instead of nm-applet";
    icon = "nm-device-wireless";
    exec = "${networkmanagerDmenu}/bin/networkmanager_dmenu";
    terminal = false;
    categories = [
      "Settings"
      "Network"
    ];
    noDisplay = false;
  };
in
{
  options.custom.desktop.components.launchers.dmenus.networkmanagerDmenu.enable =
    mkEnableOption "Fuzzel/dmenu-integrated NetworkManager connection manager";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      networkmanagerDmenu
      nmDmenuDesktopItem
    ];
  };
}
