{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-2411.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { self, inputs, ... }:
      {
        imports = [
          inputs.treefmt-nix.flakeModule
        ];

        systems = [
          "x86_64-linux"
        ];

        perSystem =
          {
            config,
            pkgs,
            system,
            ...
          }:
          {
            treefmt.config = {
              projectRootFile = "flake.nix";
              programs.nixfmt.enable = true;
              settings.formatter.nixfmt.excludes = [
                "*.age"
                "*.jpg"
                "*.png"
                "flake.lock"
              ];
            };
            devShells.default = pkgs.mkShell {
              packages = [
                inputs.agenix.packages.${system}.default
                pkgs.statix
                pkgs.deadnix
                pkgs.nixfmt
              ];
            };
          };

        flake = {
          nixosConfigurations = {

            # ---------- Lifebook Configuration ----------
            lifebook = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                { nixpkgs.hostPlatform = "x86_64-linux"; }
                ./hosts/lifebook
                inputs.home-manager.nixosModules.default
                inputs.agenix.nixosModules.default
                inputs.stylix.nixosModules.stylix
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = { inherit inputs; };
                    users.ya = {
                      imports = [
                        ./home/ya/lifebook.nix
                        inputs.nixvim.homeModules.nixvim
                        ./modules/home-manager/tui/nixvim.nix
                      ];
                    };
                  };
                }
              ];
            };

            # ---------- Trigkey Configuration ----------
            trigkey = inputs.nixpkgs-stable.lib.nixosSystem {
              specialArgs = { inherit inputs; };
              modules = [
                { nixpkgs.hostPlatform = "x86_64-linux"; }
                ./hosts/trigkey
                inputs.home-manager-stable.nixosModules.default
                inputs.agenix.nixosModules.default
                inputs.stylix-stable.nixosModules.stylix
                inputs.playit.nixosModules.default
                ./modules/nixos/services/uptime-kuma.nix
                ./modules/nixos/services/reading.nix
                (
                  { pkgs, ... }:
                  {
                    nixpkgs.overlays = [
                      (final: prev: {
                        navidrome = inputs.nixpkgs-2411.legacyPackages.${prev.stdenv.hostPlatform.system}.navidrome;
                      })
                    ];
                  }
                )
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
        };

      }
    );
}
