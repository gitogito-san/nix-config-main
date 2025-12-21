{ pkgs, ... }:

let
  font = "Hack Nerd Font";
in

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        name = "topbar";
        layer = "top";
        position = "top";
        height = 15;
        spacing = 10;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "wireplumber"
          "cpu"
          "temperature"
          "memory"
          "disk"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          "active" = "●";
          "default" = "○";
          "urgent" = "";
        };

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "○";
            active = "●";
          };
        };

        "clock" = {
          format = "{:%H:%M   %Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "󰝟";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "cpu" = {
          format = "CPU {usage}% ";
          interval = 5;
        };

        "temperature" = {
          interval = 10;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "memory" = {
          format = "Mem {}% ";
          interval = 10;
        };

        "disk" = {
          interval = 600;
          format = "Disk {percentage_used}% ";
          path = "/";
        };

        "battery" = {
          interval = 30;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰚦";
          format-plugged = "{capacity}% 󰚥";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "tray" = {
          spacing = 10;
        };
      }

      {
        name = "bottombar";
        layer = "top";
        position = "bottom";
        height = 10;
        spacing = 15;

        modules-left = [ "mpris" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "hyprland/language"
          "network"
          "custom/power"
        ];

        "mpris" = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          player-icons = {
            default = "";
            spotify = "";
            firefox = "";
          };
          status-icons = {
            paused = "";
          };
          max-length = 40;
        };

        "hyprland/window" = {
          max-length = 50;
        };

        "hyprland/language" = {
          format = " {}";
          format-en = "US";
          format-ja = "JP";
        };

        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "{ipaddr} ";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        };

        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "${pkgs.wlogout}/bin/wlogout";
        };
      }
    ];

    style = ''
      * {
      border: none;
      border-radius: 0;
      font-family: "${font}";
      min-height: 0;
      }

      window#waybar {
        opacity: 0.95; 
      }

      window#waybar.bottombar {
        opacity: 0.90;
      }

      #workspaces {
        margin: 0 5px;
      }

      #workspaces button {
        padding: 0 4px;
        transition: all 0.2s ease-in-out; 
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #tray,
      #mpris,
      #network,
      #language,
      #window,
      #wireplumber,
      #custom-power {
        padding: 0 6px;
        margin: 0;
      }

      #clock {
        font-weight: bold;
      }


      #battery.charging, #battery.plugged {
        color: #9ece6a;
      }

      #battery.critical:not(.charging) {
        animation-name: blink;
        animation-duration: 0.5s;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      #cpu { color: #7dcfff; }
      #memory { color: #bb9af7; }
      #disk { color: #e0af68; }

      #mpris {
        color: #9ece6a;
      }

      #custom-power {
        margin-right: 10px; 
      }

      @keyframes blink {
        to {
          color: #ffffff;
        }
      }
    '';
  };
}
