{ config, pkgs, ... }:

let
  start-ipad = pkgs.writeShellScriptBin "start-ipad" ''
    # 既存のゴミ掃除
    pkill wayvnc || true
    hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | xargs -I{} hyprctl output remove {} || true

    echo "Creating virtual monitor..."
    hyprctl output create headless
    sleep 1

    HEADLESS_NAME=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | head -n1)
    if [ -z "$HEADLESS_NAME" ]; then
      echo "Error: Failed to create headless monitor."
      exit 1
    fi

    # 解像度設定
    hyprctl keyword monitor "$HEADLESS_NAME, 1920x1080, 2560x0, 1"

    TS_IP=$(${pkgs.iproute2}/bin/ip -4 addr show tailscale0 | ${pkgs.gnugrep}/bin/grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    if [ -z "$TS_IP" ]; then
      echo "Error: Could not find Tailscale IP."
      exit 1
    fi

    echo "Starting WayVNC on $TS_IP..."
    nohup wayvnc --output="$HEADLESS_NAME" --max-fps=60 "$TS_IP" > /tmp/wayvnc.log 2>&1 &
  '';

  stop-ipad = pkgs.writeShellScriptBin "stop-ipad" ''
    echo "Stopping iPad screen..."
    
    # 1. 【重要】Waybar増殖防止: 親の仇のように確実に殺す
    # systemd管理外のプロセスもまとめて始末します
    pkill waybar || true
    pkill wayvnc || true
    
    HEADLESS_NAME=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | head -n1)
    MAIN_MONITOR=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS") | not) | .name' | head -n1)

    if [ -n "$HEADLESS_NAME" ]; then
      
      # 2. ワークスペース避難
      if [ -n "$MAIN_MONITOR" ]; then
        echo "Moving workspaces to $MAIN_MONITOR..."
        hyprctl -j workspaces | ${pkgs.jq}/bin/jq -r --arg h "$HEADLESS_NAME" '.[] | select(.monitor == $h) | .id' | while read -r ws_id; do
          hyprctl dispatch moveworkspacetomonitor "$ws_id $MAIN_MONITOR"
        done
        hyprctl dispatch focusmonitor "$MAIN_MONITOR"
      fi

      # 3. モニター削除
      echo "Removing output $HEADLESS_NAME..."
      hyprctl output remove "$HEADLESS_NAME"
      
      # 4. 【重要】カーソル復活の切り札: Hyprlandのリロード
      # setcursorが効かない場合でも、リロードで内部状態がリセットされカーソルが戻ります
      echo "Reloading Hyprland to restore cursor..."
      hyprctl reload
      
      # 5. Waybarの再起動
      # リロードで起動しない場合に備えて手動で起こす
      sleep 1
      echo "Starting Waybar..."
      # Home Managerのサービス経由で起動 (推奨)
      systemctl --user start waybar.service || waybar &

    else
      echo "No headless monitor found."
    fi
  '';

in
{
  home.packages = [ start-ipad stop-ipad pkgs.jq pkgs.iproute2 pkgs.gnugrep ];
}
