{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    stylix-stable.url = "github:danth/stylix/release-25.11";
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
    playit = {
      url = "github:pedorich-n/playit-nixos-module";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      home-manager-stable,
      agenix,
      stylix,
      stylix-stable,
      treefmt-nix,
      playit,
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
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./hosts/lifebook
          home-manager.nixosModules.default
          agenix.nixosModules.default
          stylix.nixosModules.stylix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.ya = ./home/ya/lifebook.nix;
            };
          }
        ];
      };
      nixosConfigurations.trigkey = nixpkgs-stable.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./hosts/trigkey
          home-manager-stable.nixosModules.default
          agenix.nixosModules.default
          stylix-stable.nixosModules.stylix
          playit.nixosModules.default
          ./modules/nixos/services/uptime-kuma.nix
          ./modules/nixos/services/reading.nix
          ./modules/nixos/services/navidrome.nix
          ./modules/nixos/services/samba.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.ya = ./home/ya/trigkey.nix;
            };
          }
        ];
      };
    };
}
