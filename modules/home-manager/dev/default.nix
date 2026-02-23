{ pkgs, ... }:

{
  home.packages = [
    pkgs.vscode
    pkgs.gcc
    pkgs.cargo
  ];
}
