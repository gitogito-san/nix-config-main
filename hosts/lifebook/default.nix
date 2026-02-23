{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core
    ../../modules/nixos/gaming/steam.nix
    ../../modules/nixos/hardware/keyboards.nix
    ../../modules/nixos/hardware/power-management.nix
    ../../modules/nixos/desktop/stylix.nix
    ../../modules/nixos/desktop/wm/hyprland
    ../../modules/nixos/desktop/wm/niri
    ../../modules/nixos/desktop/dm/greetd.nix
    ../../modules/nixos/desktop/fonts.nix
    ../../modules/nixos/desktop/addons/fcitx5.nix
    ../../modules/nixos/services/openssh.nix
    ../../modules/nixos/services/ollama.nix
  ];

  # Host
  networking.hostName = "lifebook";

  # System Packages
  environment.systemPackages = [
    pkgs.git
    pkgs.gcc
  ];

  # Firmware
  hardware.enableAllFirmware = true;

  # *DO NOT CHANGE*
  system.stateVersion = "25.11";
}
