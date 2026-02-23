{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core/default.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/adguard.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "trigkey";

  # Server Specific Services
  services.getty.autologinUser = "ya";

  # System Packages
  environment.systemPackages = [
    pkgs.git
  ];

  # DO NOT CHANGE
  system.stateVersion = "25.11";
}
