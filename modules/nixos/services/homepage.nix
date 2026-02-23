{ lib, ... }:

{
  services.homepage-dashboard = {
    enable = true;

    settings = {
      title = "Master's TRIGKEY";
      background = "https://images.unsplash.com/photo-1534796636912-3b95b3ab5986?q=80&w=2000";
      # background = "#0f172a";
      cardBlur = "sm";
    };

    services = [
      {
        "Infrastructure" = [
          {
            "Netdata" = {
              icon = "netdata";
              href = "http://100.90.113.106:19999/";
              description = "サーバーのリソース監視";
            };
          }
          {
            "AdGuard Home" = {
              icon = "adguard-home";
              href = "http://100.90.113.106:3000/";
              description = "広告ブロック・DNS";
            };
          }
        ];
      }
      {
        "Gaming" = [
          {
            "Plaiit.gg" = {
              icon = "minecraft";
              href = "https://playit.gg/account/";
              description = "マイクラサーバー";
            };
          }
        ];
      }
    ];
  };

  systemd.services.homepage-dashboard.environment = {
    HOMEPAGE_ALLOWED_HOSTS = lib.mkForce "100.90.113.106,100.90.113.106:8082,localhost,127.0.0.1";
  };
  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 8082 ];
}
