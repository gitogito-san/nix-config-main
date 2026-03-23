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
        height = 20;
        spacing = 10;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "wireplumber"
          "backlight"
          "group/hardware"
          "battery"
          "custom/notification"
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

        "backlight" = {
          device = "intel_backlight";
          format = "{percent}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
          on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
          min-length = 6;
        };

        "group/hardware" = {
          orientation = "horizontal";

          modules = [
            "cpu"
            "memory"
            "temperature"
            "disk"
          ];

          drawer = {
            transition-duration = 500;
            children-class = "hw-child";
            transition-left-to-right = false;
          };
        };

        "cpu" = {
          format = "CPU {usage}% ";
          interval = 2;
        };

        "temperature" = {
          interval = 5;
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
          interval = 5;
        };

        "disk" = {
          interval = 600;
          format = "Disk {percentage_used}% ";
          path = "/";
        };

        "battery" = {
          interval = 60;
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

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='#bf616a'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='#bf616a'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='#bf616a'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='#bf616a'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "tray" = {
          spacing = 10;
        };
      }

      {
        name = "bottombar";
        layer = "top";
        position = "bottom";
        height = 20;
        spacing = 14;

        modules-left = [ "mpris" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "network"
          "hyprland/language"
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
          interval = 2;
          format-wifi = "<span color='#7dcfff'>↓{bandwidthDownBytes}</span> <span color='#bb9af7'>↑{bandwidthUpBytes}</span> {essid} ";
          format-ethernet = "<span color='#7dcfff'>↓{bandwidthDownBytes}</span> <span color='#bb9af7'>↑{bandwidthUpBytes}</span> {ipaddr} ";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          min-length = 30;
          justify = "center";
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

       #clock,
       #battery,
       #tray,
       #mpris,
       #network,
       #language,
       #window,
       #wireplumber,
       #backlight {
         padding: 0 6px;
         margin: 0 2px; 
       }

       #clock {
         font-weight: bold;
       }

       #battery.charging, #battery.plugged, #mpris {
         color: #9ece6a;
       }
       
       #battery.critical:not(.charging) {
         animation-name: blink;
         animation-duration: 0.5s;
         animation-iteration-count: infinite;
         animation-direction: alternate;
       }

       #workspaces {
         margin: 0 5px;
       }
       #workspaces button {
         padding: 0 4px;
         transition: all 0.2s ease-in-out;
       }

      #hardware {
         margin: 0 4px;
       }
       #cpu {
         background-color: #4c566a;
         color: #88c0d0;
         padding: 0 8px;
         border-radius: 4px;
         margin: 0;
       }
       #memory, #disk, #temperature {
         background-color: #3b4252;
         padding: 0 8px;
         margin: 0 1px;
       }
       #memory { color: #bb9af7; }
       #disk { color: #e0af68; }
       #temperature { color: #81a1c1; }
       
       #hardware.hovered #cpu, #hardware.show #cpu {
         border-top-right-radius: 0;
         border-bottom-right-radius: 0;
       }

       #custom-notification {
         font-family: "Hack Nerd Font"; 
         font-size: 18px;
         padding: 0 4px;
         margin-left: 6px;  
         margin-right: 4px; 
       }

       #custom-power {
         margin-right: 12px; 
         padding: 0 6px;
       }

       @keyframes blink {
         to { color: #ffffff; }
       }
    '';

  };

  services.playerctld.enable = true;
  home.packages = [
    pkgs.playerctl
  ];
}
