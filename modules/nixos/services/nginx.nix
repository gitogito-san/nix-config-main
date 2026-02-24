{ ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."timetable" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 8080;
        }
      ];

      root = "/var/www/timetable";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/www/timetable 0775 ya users -"
  ];

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8080 ];
}
