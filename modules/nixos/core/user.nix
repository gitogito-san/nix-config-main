{ pkgs, ... }:

{
  # Shells
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # User Definition
  users.users.ya = {
    isNormalUser = true;
    description = "ya";
    extraGroups = [ "networkmanager" "wheel" "input" "strongswan" "network" ];
    shell = pkgs.zsh;
  };
}