{ ... }:

{
  imports = [
    ../../modules/home-manager/core
    ../../modules/home-manager/tui/helix.nix
    ../../modules/home-manager/tui/ssh.nix
    ../../modules/home-manager/shell/fish.nix
    ../../modules/home-manager/shell/starship.nix
    ../../modules/home-manager/cli/git.nix
    ../../modules/home-manager/cli/modern.nix
  ];

  home.username = "ya";
  home.homeDirectory = "/home/ya";
}
