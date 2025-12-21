{ pkgs, ... }:

{
  # Network Manager
  networking.networkmanager = {
    enable = true;
    plugins = [
      pkgs.networkmanager-l2tp
      pkgs.networkmanager-strongswan
    ];
  };

  # strongswan
  environment.etc."strongswan.conf".text = "";

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Tailscale
  services.tailscale.enable = true;

}
