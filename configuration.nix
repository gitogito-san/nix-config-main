
{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (map (n: ./modules + "/${n}") (builtins.attrNames (builtins.readDir ./modules)));

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #hostname
  networking.hostName = "nixos"; # Define your hostname.

  # networking
  networking.networkmanager.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # time zone
  time.timeZone = "Asia/Tokyo";

  # internationalisation properties.
  i18n.defaultLocale = "ja_JP.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # user account
  users.users.ya = {
    isNormalUser = true;
    description = "ya";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  # packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
  ];

   # experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # *DO NOT CHANGE*
  system.stateVersion = "25.11";

}
