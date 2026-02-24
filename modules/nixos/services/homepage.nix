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
      {
        "Study" = [
          {
            "Timetable" = {
              icon = "mdi-calendar-clock";
              href = "http://100.90.113.106:8080/";
              description = "時間割";
            };
          }
        ];
      }
      {
        "UEC" = [
          {
            "学務情報システム" = {
              icon = "si-nixos";
              href = "https://kyomu.office.uec.ac.jp/cp/";
              description = "履修登録・成績確認";
            };
          }
          {
            "WebClass" = {
              icon = "si-google-classroom";
              href = "https://webclass.cdel.uec.ac.jp/";
              description = "学修支援システム";
            };
          }
          {
            "UEC Portal" = {
              icon = "si-university";
              href = "https://portallms.uec.ac.jp/";
              description = "ポータルサイト";
            };
          }
          {
            "LMS" = {
              icon = "si-experiment";
              href = "https://lms.uec.ac.jp/";
              description = "実験・専門科目LMS";
            };
          }
          {
            "Google Classroom" = {
              icon = "si-google-classroom";
              href = "https://classroom.google.com/u/2/";
            };
          }
          {
            "My Library" = {
              icon = "si-bookstack";
              href = "https://opac.lib.uec.ac.jp/my/my.cgi";
            };
          }
          {
            "学内マップ" = {
              icon = "si-google-maps";
              href = "https://www.uec.ac.jp/about/profile/access/";
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
