{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core
    ../../modules/nixos/desktop/stylix.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/adguard.nix
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
