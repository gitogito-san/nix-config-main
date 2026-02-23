{ config, pkgs, ... }:

{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };
}
