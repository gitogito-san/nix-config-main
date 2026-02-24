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
          {
            "Uptime Kuma" = {
              icon = "uptime-kuma";
              href = "http://100.90.113.106:3001/";
              description = "サービスの死活監視";
            };
          }
        ];
      }
      {
        "Media" = [
          {
            "Navidrome" = {
              icon = "navidrome";
              href = "http://100.90.113.106:4533/";
              description = "音楽ストリーミング";
            };
          }
        ];
      }
      {
        "Tools" = [
          {
            "Stirling-PDF" = {
              icon = "mdi-file-pdf-box";
              href = "http://100.90.113.106:8083/";
              description = "PDF編集・OCRツール";
            };
          }
          {
            "Kavita" = {
              icon = "kavita";
              href = "http://100.90.113.106:50000/";
              description = "電子書籍・PDFリーダー";
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
              icon = "mdi-school";
              href = "https://campusweb.office.uec.ac.jp/campusweb/";
              description = "履修登録・成績確認";
            };
          }
          {
            "WebClass" = {
              icon = "mdi-presentation";
              href = "https://webclass.cdel.uec.ac.jp/webclass/";
              description = "学修支援システム";
            };
          }
          {
            "Moodle" = {
              icon = "mdi-notebook-edit";
              href = "https://joho.g-edu.uec.ac.jp/moodle3/";
              description = "共通教養科目LMS";
            };
          }
          {
            "UEC Portal" = {
              icon = "mdi-login";
              href = "https://portalweb.uec.ac.jp/Portal/";
              description = "ポータルサイト";
            };
          }
          {
            "LMS" = {
              icon = "mdi-flask";
              href = "https://lms.edu.uec.ac.jp/";
              description = "実験・専門科目LMS";
            };
          }
          {
            "Google Classroom" = {
              icon = "si-googleclassroom";
              href = "https://classroom.google.com/u/2/";
            };
          }
          {
            "My Library" = {
              icon = "si-bookstack";
              href = "https://uec.primo.exlibrisgroup.com/";
            };
          }
          {
            "学内マップ" = {
              icon = "mdi-map-marker";
              href = "https://uec-map.e-chan.me/";
            };
          }
          {
            "UBoard UEC" = {
              icon = "mdi-bookmark-multiple";
              href = "https://uboard.info/uec";
              description = "リンク集";
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
