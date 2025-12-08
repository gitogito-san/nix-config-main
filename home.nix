{ config, pkgs, ... }:

{
  imports = []
  ++ (map (n: ./home-modules + "/${n}") (builtins.attrNames (builtins.readDir ./home-modules)));
 
  home.stateVersion = "25.11";
  
  home.packages = with pkgs; [
    neofetch # system info
    btop #  Monitor of resources
    bat # cat clone
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
}
