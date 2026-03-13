{
  description = "DVD NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Disko -- declarative disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence -- persistent root storage
    impermanence = {
      url =  "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      };
      
    # Hjem -- home file management
    hjem.url = "github:feel-co/hjem";
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wallpaper Daemon
    awww = {
        url = "git+https://codeberg.org/LGFae/awww";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };
    
  }
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";

      # List of hosts to build configurations for
      hosts = [
        "fa507nur"
        "vm"
      ];
    in
    {
      # Set default formatter to nixfmt-rfc-style
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      # Function to build nixosConfigurations for each host
      nixosConfigurations = lib.genAttrs hosts (
        host:
        lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              outputs
              ;
          };
          modules = [
            ./hosts/${host} # Host-specific configurations
            # ./modules # Custom modules loaded via roles
            # (import ./overlays) # Custom overlays - TBD
          ];
        }
      );
    };
}
