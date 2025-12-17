{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch
    btop
    bat
    # ripgrep # 推奨: grepのモダンな代替
    # eza     # 推奨: lsのモダンな代替
  ];
}