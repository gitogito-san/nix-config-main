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
    stylix.url = "github:danth/stylix";
    niri.url = "github:sodiboo/niri-flake";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      stylix,
      niri,
      treefmt-nix,
      ...
    }@inputs:
    {
      formatter.x86_64-linux =
        (treefmt-nix.lib.evalModule nixpkgs.legacyPackages.x86_64-linux {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
          settings.formatter.nixfmt.excludes = [
            "*.age"
            "*.jpg"
            "*.png"
            "flake.lock"
          ];
        }).config.build.wrapper;

      nixosConfigurations.lifebook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/lifebook/default.nix
          home-manager.nixosModules.default
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          niri.nixosModules.niri
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.ya = ./home/ya;
            };
          }
        ];
      };
    };
}
