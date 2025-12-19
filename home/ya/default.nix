{
  imports = [
    ../../modules/home-manager/core
    ../../modules/home-manager/shell/zsh.nix
    ../../modules/home-manager/shell/utils.nix
    ../../modules/home-manager/tui/helix.nix
    ../../modules/home-manager/tui/ssh.nix
    ../../modules/home-manager/desktop/apps.nix
    ../../modules/home-manager/desktop/cursor.nix
    ../../modules/home-manager/desktop/wm/hyprland
    ../../modules/home-manager/desktop/addons/ipad-screen.nix
    ../../modules/home-manager/dev
  ];

  # User
  home.username = "ya";
  home.homeDirectory = "/home/ya";

}
