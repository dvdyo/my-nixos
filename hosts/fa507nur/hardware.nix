{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./disko.nix
  ];

  # 1. CPU & Kernel
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # 2. Graphics (Nvidia Only - No iGPU)
   hardware.graphics = {
     enable = true;
     enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
   };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    QSG_RENDER_LOOP = "threaded";
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Required for stable suspend/resume on many laptops.
    powerManagement.enable = true;
    # Fine-grained power management. Turns off GPU when not in use.
    powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures.
    open = true;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    # Prime Offload options - DISABLED (No iGPU)
    # prime = ...
  };

  # 3. ASUS Specifics
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  services.supergfxd.enable = false;
}
