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

  custom.programs.git.enable = true;
}