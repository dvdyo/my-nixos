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
  custom.programs = {
    git.enable = true;
    nh.enable = true;
    fish.enable = true;
    zoxide.enable = true;
    microfetch.enable = true;
    starship.enable = true;
    direnv.enable = true;
    eza.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    bat.enable = true;
  };
}