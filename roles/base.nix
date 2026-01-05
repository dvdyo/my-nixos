{ ... }:
{
  imports = [
    ../modules
  ];

  # --- Base Policy ---
  custom.core.enable = true;
  custom.hjem.enable = true;

  # Enable full shell suite (fish, starship, bat, eza, etc.)
  custom.shell.enable = true;

  # Essential Tools (Not part of shell suite)
  custom.git.enable = true;

  # Basic Editor
  custom.editors.vim = {
    enable = true;
  };
}
