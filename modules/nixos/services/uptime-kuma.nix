{ ... }:

{
  services.uptime-kuma = {
    enable = true;
  };

  systemd.services.uptime-kuma.environment = {
    UPTIME_KUMA_HOST = "0.0.0.0";
    UPTIME_KUMA_PORT = "3001";
  };

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 3001 ];
}
