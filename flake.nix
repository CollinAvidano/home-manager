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

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";


    stdlib-pretty-printers = {
      flake = false;
      url = "https://gcc.gnu.org/git/gcc.git?dir=libstdc++-v3/python/";
      # sparseCheckout = [ "libstdc++-v3/python" ];
      # sparseCheckout = "libstdc++-v3/python/";
      # subtree = "libstdc++-v3/python/";
    };
    # includes other printers (lldb and msvc) as well
    eigen-pretty-printers = {
      flake = false;
      url = "https://gitlab.com/libeigen/eigen.git";
      # url = "https://gitlab.com/libeigen/eigen.git?dir=debug/";
      # gitlab does not seem to support dir for this
      # sparseCheckout = [ "debug" ];
      # sparseCheckout = "debug/";
      # subtree = "debug/";
    };
    boost-pretty-printers = {
      flake = false;
      url = https://github.com/ruediger/Boost-Pretty-Printer.git;
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
    homeConfigurations."collin" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = inputs;
    };

    nixosConfigurations = {
      aegis = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          "${nixpkgs}/modules/installer/cd-dvd/installation-cd-minimal.nix"
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."collin" = import ./home.nix;
          }
        ];
      };
    };
    systemConfigs.default = system-manager.lib.makeSystemConfig {
      modules = [
        ./home.nix
        ./home/i3.nix
        "${nixos-hardware}/lenovo/thinkpad/t14" # uses default module
      ];
      extraArgs = inputs;
    };
  };
}
