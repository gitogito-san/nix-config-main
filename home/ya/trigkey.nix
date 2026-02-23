{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager/core/default.nix
    ../../modules/home-manager/tui/helix.nix
    ../../modules/home-manager/tui/ssh.nix
    ../../modules/home-manager/shell/fish.nix
    ../../modules/home-manager/shell/starship.nix
  ];

  home.username = "ya";
  home.homeDirectory = "/home/ya";
}
