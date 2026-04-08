{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core
    ../../modules/nixos/core/network-common.nix
    ../../modules/nixos/core/network-server.nix
    ../../modules/nixos/desktop/stylix.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/adguard.nix
    ../../modules/nixos/services/docker.nix
    ../../modules/nixos/services/minecraft.nix
    ../../modules/nixos/services/playit.nix
    ../../modules/nixos/services/netdata.nix
    ../../modules/nixos/services/homepage.nix
    ../../modules/nixos/services/nginx.nix
  ];

  # Host
  networking.hostName = "trigkey";

  # Server Specific Services
  services.getty.autologinUser = "ya";

  # System Packages
  environment.systemPackages = [ ];

  # DO NOT CHANGE
  system.stateVersion = "25.11";
}
