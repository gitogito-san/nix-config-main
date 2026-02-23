{ lib, ... }:

{
  services.homepage-dashboard = {
    enable = true;

    settings = {
      title = "shortcut list";
      background = "#022c22";
      theme = "dark";
      cardBlur = "md";
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
