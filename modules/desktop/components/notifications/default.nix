{
  pkgs,
  ...
}:
{
  imports = [
    ./mako.nix
  ];
  environment.systemPackages = [ pkgs.libnotify ];
}
