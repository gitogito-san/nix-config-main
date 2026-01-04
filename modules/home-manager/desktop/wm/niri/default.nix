{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.niri.settings = {
    "window-rules" = [
      {
        matches = [ { } ];
        clip-to-geometry = true;
      }
    ];
    layout = {
      center-focused-column = "never";

      focus-ring = {
        enable = true;
        width = 3;
      };

      border = {
        enable = false;
      };

      gaps = 6;
      default-column-width.proportion = 0.5;

      "preset-column-widths" = [
        { proportion = 0.333333333333333; }
        { proportion = 0.5; }
        { proportion = 0.666666666666666; }
        { proportion = 1.0; }
      ];
    };

    input = {
      keyboard = {
        xkb = {
          layout = "jp";
          options = "caps:none";
        };
        repeat-delay = 250;
        repeat-rate = 40;
      };
      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true;
        drag-lock = true;
      };
      focus-follows-mouse.enable = true;
    };

    spawn-at-startup = [
      { command = [ "${pkgs.waybar}/bin/waybar" ]; }
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
      { command = [ "${pkgs.fuzzel}/bin/fuzzel" ]; }
    ];

    binds =
      with config.lib.niri.actions;
      let
        workspaceBinds = builtins.listToAttrs (
          lib.concatMap (
            i:
            let
              key = if i == 10 then "0" else toString i;
            in
            [
              {
                name = "Mod+${key}";
                value.action.focus-workspace = i;
              }
              {
                name = "Mod+Shift+${key}";
                value.action.move-column-to-workspace = i;
              }
            ]
          ) (lib.range 1 10)
        );
      in
      {
        "Mod+Return".action = spawn "${pkgs.alacritty}/bin/alacritty";
        "Mod+Q".action = close-window;
        "Mod+T".action = spawn "${pkgs.thunar}/bin/thunar";
        "Mod+E".action = spawn "${pkgs.wlogout}/bin/wlogout";
        "Mod+L".action = spawn "${pkgs.swaylock-effects}/bin/swaylock";
        "Mod+R".action.spawn = [
          "${pkgs.fuzzel}/bin/fuzzel"
          "--hide-before-typing"
          "--lines"
          "3"
          "--width"
          "40"
        ];
        "Mod+M".action = quit;
        "Mod+V".action.spawn = [
          "sh"
          "-c"
          ''
            ${pkgs.cliphist}/bin/cliphist list | \
            ${pkgs.fuzzel}/bin/fuzzel --dmenu --lines 5 --width 40 | \
            ${pkgs.cliphist}/bin/cliphist decode | \
            ${pkgs.wl-clipboard}/bin/wl-copy
          ''
        ];

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

        "Mod+Home".action = consume-or-expel-window-left;
        "Mod+End".action = consume-or-expel-window-right;

        "Mod+WheelScrollUp".action.focus-workspace-up = { };
        "Mod+WheelScrollDown".action.focus-workspace-down = { };
        "Mod+Shift+WheelScrollUp".action.focus-column-left = { };
        "Mod+Shift+WheelScrollDown".action.focus-column-right = { };

        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Mod+S".action = switch-preset-column-width;

        "Mod+Space".action = toggle-window-floating;
        "Mod+Tab".action = toggle-overview;

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

        "Mod+Print".action.spawn = [
          "sh"
          "-c"
          "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy"
        ];
        "Mod+Shift+Print".action.spawn = [
          "sh"
          "-c"
          ''
            DIR="$HOME/Pictures/Screenshots"
            FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
            mkdir -p "$DIR"
            ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" "$FILE" && \
            ${pkgs.libnotify}/bin/notify-send "Screenshot Captured" "Saved to $FILE" -i camera-photo
          ''
        ];
      }
      // workspaceBinds;

  };

  home.sessionVariables = {
    GTK_CSD = "0";
    LIBDECOR_PRESENTATION = "none";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
