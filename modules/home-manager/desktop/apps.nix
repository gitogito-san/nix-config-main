{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    google-chrome
    discord
    vial
  ];
  
}