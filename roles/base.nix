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

  # Minimum Tools
  custom.programs.git.enable = true;
  custom.programs.nh.enable = true;
}