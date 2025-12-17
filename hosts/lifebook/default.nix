{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/system.nix
    ../../modules/core/power-management.nix
    ../../modules/gui.nix  
   ];

  # Host
  networking.hostName = "lifebook"; 

  # SSH
  services.openssh = {
    enable = true;
    openFirewall = false;
  };

  # Users
  users.users.ya = {
    isNormalUser = true;
    description = "ya";
    extraGroups = [ "networkmanager" "wheel" "input" "strongswan" "network" ];
    shell = pkgs.zsh;
  };
  # Zsh
  programs.zsh.enable = true;

  # Fish
  programs.fish.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    age
  ];

  # Agenix
  age.identityPaths = [ 
    "/etc/ssh/ssh_host_ed25519_key"  
    "/home/ya/.ssh/id_agenix"     
  ];
  age.secrets = {
    copilotApiKey = {
      file = ../../secrets/copilot-api-key.age;
      owner = "ya";
      group = "users";
      mode = "400";
    };
    geminiApiKey = {
      file = ../../secrets/gemini-api-key.age;
      owner = "ya";
      group = "users";
      mode = "400";
    };
  };

  # Hardware/Device Specific Rules
  services.udev.extraRules = ''
    # SayoDevice (ID: 8089)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="8089", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="8089", MODE="0666"
    # Corne v4 (ID: 4653)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4653", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", MODE="0666"
  '';
  
  # Firmware
  hardware.enableRedistributableFirmware = true;

  # *DO NOT CHANGE*
  system.stateVersion = "25.11";

}
