{
  description = "Home Manager configuration of collin";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-hardware,
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
  };
}
