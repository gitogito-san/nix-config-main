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
      };
    };
  };

  # Packages
  home.packages = with pkgs; [
    # rust-analyzer (Rust開発用)
    # nodePackages.typescript-language-server (TypeScript開発用)
    # 
    # 今は最小限の構成で進めます
  ];
}
