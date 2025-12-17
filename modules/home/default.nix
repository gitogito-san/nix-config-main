{ config, pkgs, ... }:

{
  home.username = "ya";
  home.homeDirectory = "/home/ya";
  home.stateVersion = "25.11";

  # ★ ここが「最強」のポイント：
  # 自動読み込みをやめ、何を使っているかを明示的に書く！
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

  # 共通パッケージ
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
  
  # Home Manager自体の管理を有効化
  programs.home-manager.enable = true;
}
