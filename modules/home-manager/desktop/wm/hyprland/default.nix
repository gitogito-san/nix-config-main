{ config, pkgs, ... }:

{
  # packages
  home.packages = with pkgs; [
    # GUI必須
    alacritty
    fuzzel
    waybar
    dunst
    libnotify
    networkmanagerapplet
    wlogout
    hyprpaper
    xfce.thunar          # 本体
    xfce.thunar-volman   # USBメモリ等の自動マウント管理 (あると便利)
    xfce.thunar-archive-plugin # 圧縮・解凍プラグイン (あると便利)
    blueman
    wayvnc

    # クリップボード・スクショ・ロック画面
    wl-clipboard  # wl-copy / wl-paste
    cliphist      # クリップボード履歴
    grim          # スクリーンショット
    slurp         # 範囲選択
    swaylock-effects # ロック画面 (swaylockより高機能)
    jq            # JSON処理 (スクショスクリプトで使用)
    zenity        # ファイル保存ダイアログ (スクショスクリプトで使用)

    # 音量・輝度
    playerctl
    brightnessctl
    wireplumber
  ];

  # 2. Hyprland 設定
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$menu" = "fuzzel --hide-before-typing --lines 3 --width 40"; 
      
      monitor = ",preferred,auto,1";

      exec-once = [
        "hyprpaper"
        "zsh -c 'sleep 1 && pgrep .waybar || waybar'"
        "fcitx5 -d"
        "dunst"
        "nm-applet --indicator"
        "zsh -c 'sleep 1 && blueman-applet &'"
        "mkdir -p $HOME/Pictures/Screenshots"
        "wl-paste --watch cliphist store &"
        "blueman-applet"
      ];

      # 環境変数
      env = [
        "XCURSOR_SIZE,24"
      ];

      # 外観 (General)
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 3;
        "col.active_border" = "0xFF008000";
        "col.inactive_border" = "0xFF202500";
        resize_on_border = false;
        layout = "dwindle";
      };

      # 装飾 (Decoration)
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
        enabled = false;
      };

      # 入力設定 (US配列)
      input = {
        kb_layout = "jp";
        repeat_rate = 50;
        repeat_delay = 300;
        touchpad = {
          natural_scroll = true;
          drag_lock = true;
          disable_while_typing = true;
        };
      };

      # ウィンドウルール
      windowrule = [
        "float, class:^(org.pulseaudio.pavucontrol)$"
        "float, class:^(xdg-desktop-portal-gtk)$"
        "float, class:^(.blueman-manager-wrapped)$"
        "center, class:^(org.pulseaudio.pavucontrol)$"
        "center, class:^(xdg-desktop-portal-gtk)$"
        "center, class:^(.blueman-manager-wrapped)$"
      ];

      # ==========================================
      # ⌨️ キーバインド (メイン機 + HJKL移動)
      # ==========================================
      bind = [
        # アプリ起動
        "$mainMod, RETURN, exec, $terminal" 
        "$mainMod, Q, killactive,"
        "$mainMod, T, exec, thunar"
        "$mainMod, R, exec, $menu"
        "$mainMod, L, exec, swaylock -f --screenshots --clock --effect-blur 7x5 --indicator --fade-in 0.5 --font 'Noto Sans CJK JP'"
        "$mainMod, E, exec, wlogout"
        "$mainMod, V, exec, cliphist list | fuzzel -d -w 80% | cliphist decode | wl-copy"
        "$mainMod, M, exit,"
        
        # --- ウィンドウ移動 ---
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # --- ウィンドウ入れ替え ---
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

        # --- ワークスペース ---
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

        # --- スクリーンショット ---
        ", Print, exec, bash -c 'FILEPATH=$(zenity --file-selection --save --confirm-overwrite --filename=\"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S_active.png)\"); [ -n \"$FILEPATH\" ] && grim -g \"$(hyprctl activewindow -j | jq -r \"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\")\" \"$FILEPATH\"'"
        "SHIFT, Print, exec, bash -c 'FILEPATH=$(zenity --file-selection --save --confirm-overwrite --filename=\"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S_all.png)\"); [ -n \"$FILEPATH\" ] && grim \"$FILEPATH\"'"
        "$mainMod, Print, exec, grim -g \"$(slurp)\" - | wl-copy"

        # --- その他 ---
        "$mainMod, F, fullscreen"
        "$mainMod, space, togglefloating"
    
        # --- リサイズ ---
        "$mainMod CTRL, left, resizeactive, -40 0"
        "$mainMod CTRL, right, resizeactive, 40 0"
        "$mainMod CTRL, up, resizeactive, 0 -40"
        "$mainMod CTRL, down, resizeactive, 0 40"
      ];

      # メディアコントロール (binde / bindl)
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      
      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", switch:on:Lid Switch, exec, hyprctl dispatch dpms off"
        ", switch:off:Lid Switch, exec, hyprctl dispatch dpms on"
      ];
    };
  };
}
