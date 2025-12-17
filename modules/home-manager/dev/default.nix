{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    nodejs_24
  ];
}