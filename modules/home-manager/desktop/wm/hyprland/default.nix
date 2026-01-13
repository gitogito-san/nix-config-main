{ pkgs, ... }:

let
  terminal = "${pkgs.alacritty}/bin/alacritty";
  menu = "${pkgs.fuzzel}/bin/fuzzel";
  fileManager = "${pkgs.thunar}/bin/thunar";
  lock = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bb00cc --key-hl-color 880033 --font 'Noto Sans CJK JP'";

  # Tools
  jq = "${pkgs.jq}/bin/jq";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wlCopy = "${pkgs.wl-clipboard}/bin/wl-copy";
  wlPaste = "${pkgs.wl-clipboard}/bin/wl-paste";
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  zenity = "${pkgs.zenity}/bin/zenity";

  # Audio / Hardware
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

  # Screenshot
  screenshotActive = pkgs.writeShellScript "screenshot-active" ''
    FILEPATH=$(${zenity} --file-selection --save --confirm-overwrite --filename="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S_active.png)")
    if [ -n "$FILEPATH" ]; then
      ${grim} -g "$(${pkgs.hyprland}/bin/hyprctl activewindow -j | ${jq} -r "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])")" "$FILEPATH"
    fi
  '';
  screenshotAll = pkgs.writeShellScript "screenshot-all" ''
    FILEPATH=$(${zenity} --file-selection --save --confirm-overwrite --filename="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S_all.png)")
    if [ -n "$FILEPATH" ]; then
      ${grim} "$FILEPATH"
    fi
  '';

  # scratchpad
  toggleTerm = pkgs.writeShellScriptBin "toggle-term" ''
    if ! ${pkgs.hyprland}/bin/hyprctl clients -j | ${jq} -e '.[] | select(.class == "scratchpad")' > /dev/null; then
      ${pkgs.hyprland}/bin/hyprctl dispatch exec "[workspace special:scratch;float;size 99% 40%;move 3 30] ${pkgs.alacritty}/bin/alacritty --class scratchpad"
    else
      ${pkgs.hyprland}/bin/hyprctl dispatch togglespecialworkspace scratch
    fi
  '';

  # web search
  webSearch = pkgs.writeShellScriptBin "web-search" ''
    QUERY=$(echo "" | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt "  Search: ")
    if [ -n "$QUERY" ]; then
      ${pkgs.firefox}/bin/firefox --search "$QUERY"
    fi
  '';

in

{
  # packages
  home.packages = [
    pkgs.networkmanagerapplet
    pkgs.wlogout
    pkgs.thunar
    pkgs.thunar-volman
    pkgs.thunar-archive-plugin
    pkgs.blueman
    pkgs.wayvnc

    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.grim
    pkgs.slurp
    pkgs.swaylock-effects
    pkgs.jq
    pkgs.zenity

    pkgs.brightnessctl
    pkgs.wireplumber

    toggleTerm
    webSearch
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
      };
    };
  };

  # lock password
  services.swayidle = {
    enable = true;
    events = {
      lock = lock;
      before-sleep = "${pkgs.swaylock-effects}/bin/swaylock -f";
    };
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = terminal;
      "$menu" = "${menu} --hide-before-typing --lines 3 --width 40";

      monitor = ",preferred,auto,1";

      misc = {
        vfr = true;
        vrr = 1;
      };

      exec-once = [
        "swww-daemon"
        "${pkgs.waybar}/bin/waybar"
        "fcitx5 -d"
        "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"
        "${pkgs.blueman}/bin/blueman-applet"
        "mkdir -p $HOME/Pictures/Screenshots"
        "${wlPaste} --type text --watch ${cliphist} store"
        "${wlPaste} --type image --watch ${cliphist} store"
      ];

      # env variables
      env = [ ];

      # General
      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 3;
        resize_on_border = false;
        layout = "dwindle";
        no_focus_fallback = true;
      };

      # Decoration
      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        blur = {
          enabled = false;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "workspace_curve, 0.17, 0.84, 0.44, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "workspaces, 1, 2.5, workspace_curve, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      # input
      input = {
        kb_layout = "jp";
        repeat_rate = 40;
        repeat_delay = 250;
        touchpad = {
          natural_scroll = true;
          drag_lock = true;
          disable_while_typing = true;
        };
      };

      device = [
        {
          name = "foostan-corne-v4";
          kb_layout = "us";
        }
        {
          name = "foostan-corne-v4-keyboard";
          kb_layout = "us";
        }
      ];

      # winwindowrule
      windowrulev2 = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(xdg-desktop-portal-gtk)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "center, class:^(org.pulseaudio.pavucontrol)$"
        "center, class:^(xdg-desktop-portal-gtk)$"
        "center, class:^(.blueman-manager-wrapped)$"
        "float, class:^(scratchpad)$"
        "workspace special:scratch, class:^(scratchpad)$"
        "noborder, class:^(scratchpad)$"
        "move 0 30, class:^(scratchpad)$"
        "size 100% 40%, class:^(scratchpad)$"
        "animation slide top 1 1.5 md3_decel, class:^(scratchpad)$"
      ];

      # bind
      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod SHIFT, Return, exec, ${toggleTerm}/bin/toggle-term"
        "$mainMod, Q, killactive,"
        "$mainMod, T, exec, ${fileManager}"
        "$mainMod, R, exec, $menu"
        "$mainMod SHIFT, R, exec, ${webSearch}/bin/web-search"
        "$mainMod, E, exec, ${pkgs.wlogout}/bin/wlogout"
        "$mainMod, L, exec, ${lock} -f --screenshots --clock --effect-blur 7x5 --indicator --fade-in 0.5 --font 'Noto Sans CJK JP'"
        "$mainMod, V, exec, ${cliphist} list | ${menu} -d -w 80% | ${cliphist} decode | ${wlCopy}"
        "$mainMod, M, exit,"

        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # screenshot
        ", Print, exec, ${screenshotActive}"
        "SHIFT, Print, exec, ${screenshotAll}"
        "$mainMod, Print, exec, ${grim} -g \"$(${slurp})\" - | ${wlCopy}"

        # window change rule
        "$mainMod, F, fullscreen"
        "$mainMod, space, togglefloating"

        # resize
        "$mainMod CTRL, left, resizeactive, -40 0"
        "$mainMod CTRL, right, resizeactive, 40 0"
        "$mainMod CTRL, up, resizeactive, 0 -40"
        "$mainMod CTRL, down, resizeactive, 0 40"
      ];

      # binde / bindl
      binde = [
        ", XF86AudioRaiseVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, ${brightnessctl} set 5%+"
        ", XF86MonBrightnessDown, exec, ${brightnessctl} set 5%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
    };
  };
}
