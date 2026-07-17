{
  description = "Wifi toys suite";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    devShells."x86_64-linux".default = pkgs.mkShell {
      packages = with pkgs; [
        # WPA stuff
        aircrack-ng
        airgeddon
        bully
        hcxtools
        hcxdumptool
        pixiewps
        # for passwords
        crunch
        hashcat
        hashcat-utils
      ];
      
    };
  };
}
