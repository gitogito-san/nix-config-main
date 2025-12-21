{ pkgs, config, ... }:

{
  programs.niri.settings = {
    layout = {
      border.enable = true;
      focus-ring.enable = true;
      gaps = 4;
      default-column-width = {
        proportion = 0.5;
      };
    };

    input = {
      keyboard.xkb.layout = "jp";
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    gestures.hot-corners = {
      # 何も書かないことで、デフォルトの top-left を「空」で上書きする
    };

    spawn-at-startup = [
      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
      { command = [ "${pkgs.swww}/bin/swww-daemon" ]; }
      {
        command = [
          "fcitx5"
          "-d"
        ];
      }
      { command = [ "${pkgs.dunst}/bin/dunst" ]; }
      {
        command = [
          "${pkgs.networkmanagerapplet}/bin/nm-applet"
          "--indicator"
        ];
      }
      { command = [ "${pkgs.blueman}/bin/blueman-applet" ]; }
      {
        command = [
          "sh"
          "-c"
          "${pkgs.wl-clipboard}/bin/wl-paste"
          "--type"
          "text"
          "--watch"
          "${pkgs.cliphist}/bin/cliphist"
          "store"
        ];
      }
      {
        command = [
          "sh"
          "-c"
          "${pkgs.wl-clipboard}/bin/wl-paste"
          "--type"
          "image"
          "--watch"
          "${pkgs.cliphist}/bin/cliphist"
          "store"
        ];
      }
      {
        command = [
          "sh"
          "-c"
          "mkdir -p $HOME/Pictures/Screenshots"
        ];
      }
      {
        command = [
          "${pkgs.wireplumber}/bin/wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.0"
        ];
      }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "${pkgs.alacritty}/bin/alacritty";
      "Mod+Q".action = close-window;
      "Mod+T".action = spawn "${pkgs.xfce.thunar}/bin/thunar";
      "Mod+R".action = spawn "${pkgs.fuzzel}/bin/fuzzel";
      "Mod+M".action = quit;

      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      "Mod+0".action = focus-workspace 10;

      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Up".action = focus-window-up;
      "Mod+Down".action = focus-window-down;

      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-window-up;
      "Mod+Shift+Down".action = move-window-down;

      "Mod+Page_Up".action = focus-workspace-up;
      "Mod+Page_Down".action = focus-workspace-down;
      "Mod+Shift+Page_Up".action = move-window-to-workspace-up;
      "Mod+Shift+Page_Down".action = move-window-to-workspace-down;

      "Mod+F".action = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      "Mod+Space".action = toggle-window-floating;
      "Mod+Tab".action = toggle-window-floating;

      "Mod+Comma".action = set-column-width "-10%";
      "Mod+Period".action = set-column-width "+10%";
      "Mod+C".action = center-column;

      "Mod+Slash".action = show-hotkey-overlay;

      "XF86AudioRaiseVolume".action =
        spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@"
          "0.05+";
      "XF86AudioLowerVolume".action =
        spawn "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@"
          "0.05-";
      "XF86AudioMute".action =
        spawn "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@"
          "toggle";

      "XF86MonBrightnessUp".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+";
      "XF86MonBrightnessDown".action = spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-";
    };

  };

  home.sessionVariables = {
    GTK_CSD = "0";
  };
}
