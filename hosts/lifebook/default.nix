{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core
    ../../modules/nixos/hardware/keyboards.nix
    ../../modules/nixos/hardware/power-management.nix
    ../../modules/nixos/desktop/stylix.nix
    ../../modules/nixos/desktop/wm/hyprland
    ../../modules/nixos/desktop/dm/ly.nix
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/addons/fcitx5.nix
    ../../modules/nixos/services/openssh.nix
  ];

  # Host
  networking.hostName = "lifebook";

  # System Packages
  environment.systemPackages = [
    pkgs.git
  ];

  # Firmware
  hardware.enableAllFirmware = true;

  # *DO NOT CHANGE*
  system.stateVersion = "25.11";
}
