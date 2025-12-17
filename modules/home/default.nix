{ config, pkgs, ... }:

{
  home.username = "ya";
  home.homeDirectory = "/home/ya";

  # *DO NOT CHANGE*
  home.stateVersion = "25.11";

  imports = [
    # CLI / Shell
    ../features/cli/zsh.nix
    ../features/cli/ssh.nix

    # Desktop Environment
    ../features/hyprland/default.nix
    ../features/gui/ipad-screen.nix

    # Apps
    ../features/apps/helix.nix
  ];

  # Packages
  home.packages = with pkgs; [
    neofetch
    btop
    bat
    vial
    firefox
    discord
    google-chrome
    vscode
    nodejs_24
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  # Home Manager
  programs.home-manager.enable = true;
}
