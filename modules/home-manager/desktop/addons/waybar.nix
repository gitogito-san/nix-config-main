{ pkgs, ... }:

let
  font = "Hack Nerd Font";
  colors = {
    background = "#1a1b26";
    backgroundAlt = "#24283b";
    foreground = "#c0caf5";
    primary = "#7aa2f7";
    secondary = "#bb9af7";
    alert = "#f7768e";
    disabled = "#565f89";
  };
in

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        name = "topbar";
        layer = "top";
        position = "top";
        height = 10;
        spacing = 10;

        modules-left = [ "hyprland/workspaces" ];
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
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "active" = "";
            "default" = "";
            "urgent" = "";
          };
        };

        "clock" = {
          format = "{:%H:%M   %Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = " Muted";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "cpu" = {
          format = "CPU {usage}% ";
          interval = 2;
        };

        "temperature" = {
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
          interval = 2;
        };

        "disk" = {
          format = "Disk {percentage_used}% ";
          path = "/";
        };

        "battery" = {
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
        spacing = 10;

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
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: ${colors.background};
        color: ${colors.foreground};
        opacity: 0.95; 
      }

      window#waybar.bottombar {
        opacity: 0.90;
        font-size: 11px; 
      }

      #workspaces {
        margin: 0 5px;
      }

      #workspaces button {
        padding: 0 4px;
        color: ${colors.primary};
        font-size: 10px;
        transition: all 0.2s ease-in-out; 
      }

      #workspaces button:hover {
        color: ${colors.foreground};
        background-color: rgba(255, 255, 255, 0.1); 
        box-shadow: inset 0 -1px 0 ${colors.foreground}; 
      }

      #workspaces button.active {
        color: ${colors.secondary};
        background-color: transparent;
        border-bottom: 1px solid ${colors.secondary}; 
      }

      #workspaces button.urgent {
        color: ${colors.alert};
        background-color: rgba(247, 118, 142, 0.2); 
      }

      #workspaces button.persistent {
        color: ${colors.disabled};
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
        color: ${colors.foreground};
      }

      #clock {
        color: ${colors.secondary};
        font-weight: bold;
      }

      #wireplumber { color: ${colors.primary}; } 
      #wireplumber.muted { color: ${colors.disabled}; }

      #battery.charging, #battery.plugged {
        color: #9ece6a;
      }

      #battery.critical:not(.charging) {
        color: ${colors.alert};
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

      #network {
        color: ${colors.primary};
      }

      #custom-power {
        color: ${colors.alert};
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
