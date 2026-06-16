{ pkgs, ... }:

{
  # Shells
  programs.fish.enable = true;

  # User Definition
  users.users.ya = {
    isNormalUser = true;
    description = "ya";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "strongswan"
      "network"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQudxqP1y+lmBwCpPE+JkpdVHK9FPw8n0IibALGEbwL ya@nixos"
    ];
  };

  nix.settings.trusted-users = [
    "root"
    "ya"
  ];
}
