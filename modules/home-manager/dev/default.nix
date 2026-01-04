{ pkgs, ... }:

{
  home.packages = [
    pkgs.vscode
    pkgs.cargo
  ];
}
