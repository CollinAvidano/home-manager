{
  description = "Home Manager configuration of collin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixseperatedebuginfod.url = "github:symphorien/nixseparatedebuginfod";

    stdlib-pretty-printers = {
      flake = false;
      url = "git+https://gcc.gnu.org/git/gcc.git";
    };
    # includes other printers (lldb and msvc) as well
    eigen-pretty-printers = {
      flake = false;
      url = "git+https://gitlab.com/libeigen/eigen.git";
    };
    boost-pretty-printers = {
      flake = false;
      url = "github:ruediger/Boost-Pretty-Printer";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
    system-manager,
    ...
  }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
  {

    # config if you directly import
    homeConfigurations."collin" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        (./home.nix)
        ({ ... } : { targets.genericLinux.enable = true; })
      ];
      extraSpecialArgs = { inherit inputs; };
    };

    nixosConfigurations = {
      aegis = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (home-manager.nixosModules.home-manager {
            # double check if you should use these 2
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."collin" = import ./home.nix;
          })
          ({ ... } : { targets.genericLinux.enable = true; })

        ];
      };
    };

    systemConfigs.default = system-manager.lib.makeSystemConfig {
      modules = [
        ./home.nix
        ./modules/system/i3.nix
        # "${nixos-hardware}/lenovo/thinkpad/t14" # uses default module
      ];
      extraArgs = inputs;
    };

  };
}
