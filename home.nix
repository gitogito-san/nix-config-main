{ config, pkgs, ... }:

{
  imports = []
  ++ (map (n: ./home-modules + "/${n}") (builtins.attrNames (builtins.readDir ./home-modules)));
 
  home.stateVersion = "25.11";
  
  home.packages = with pkgs; [
    neofetch # system info
    btop #  Monitor of resources
    bat # cat clone 
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };
}
