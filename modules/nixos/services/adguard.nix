{ ... }:

{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.interfaces."tailscale0" = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
