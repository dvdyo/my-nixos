{ ... }:
{
  imports = [
    ../modules
  ];

  # --- Base Policy ---
  custom.core = {
    user.enable = true;
    hjem.enable = true;
  };

  # Enable full shell suite (fish, starship, bat, eza, etc.)
  custom.shell.enable = true;

  # Essential Tools (Not part of shell suite)
  custom.git.enable = true;

  # Basic Editor
  custom.editors.vim = {
    enable = true;
    defaultEditor = true;
  };
}
