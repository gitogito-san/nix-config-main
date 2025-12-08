{ config, pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "jellybeans";
      editor = {
        line-number = "relative";
        cursorcolumn = true;
        true-color = true;
        idle-timeout = 0;
        clipboard-provider = "wayland";
        default-yank-register = "+";
        };
    };
  };

  # Packages
  home.packages = with pkgs; [
    # rust-analyzer (Rust開発用)
    # nodePackages.typescript-language-server (TypeScript開発用)
  ];
}
