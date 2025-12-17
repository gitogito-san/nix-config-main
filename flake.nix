{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        lifebook = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/lifebook/default.nix
            home-manager.nixosModules.default
            agenix.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.ya = ./modules/home/default.nix;
              };
            }
          ];
        };
      };
    };
}
