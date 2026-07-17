{ ... }:
{
  imports = [
    ../modules
  ];
  custom = {
    core.enable = true;
    hjem.enable = true;
    shell.enable = true;
    git.enable = true;
  };
}
