{ pkgs, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."timetable" = {
      default = true;
      listen = [
        {
          addr = "0.0.0.0";
          port = 8080;
        }
      ];

      root = "/var/www/timetable";

      locations."/api/" = {
        proxyPass = "http://127.0.0.1:3002";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/www/timetable 0775 ya users -"
  ];

  systemd.services.timetable-backend = {
    description = "Timetable Node.js Backend API";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nodejs}/bin/node /var/www/timetable/server.js";
      Restart = "always";
      User = "ya";
      StateDirectory = "timetable-backend";
    };
  };

  services.resolved.extraConfig = "DNSStubListener=no";

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8080 ];
}
