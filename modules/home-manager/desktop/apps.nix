{ pkgs, ... }:

{
  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
    pkgs.discord
    pkgs.vial
  ];

}
