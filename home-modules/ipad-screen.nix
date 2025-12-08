{ config, pkgs, ... }:

let
  start-ipad = pkgs.writeShellScriptBin "start-ipad" ''
    # 1. 古いプロセスと画面を掃除
    pkill wayvnc || true
    hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | xargs -I{} hyprctl output remove {} || true
    
    echo "Creating virtual monitor..."
    hyprctl output create headless
    
    # 2. 作成待ち
    sleep 2

    # 3. 画面名を自動検出
    HEADLESS_NAME=$(hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | head -n1)

    if [ -z "$HEADLESS_NAME" ]; then
      echo "Error: Failed to create headless monitor."
      exit 1
    fi

    echo "Monitor created: $HEADLESS_NAME"

    # 4. 解像度と配置
    hyprctl keyword monitor "$HEADLESS_NAME, 1920x1080, 2560x0, 1"

    # 5. VNCサーバー起動 (ここを書き換えました！)
    # ---------------------------------------------------------
    # TailscaleのIPアドレスを取得 (tailscale0インターフェースのIP)
    TS_IP=$(${pkgs.iproute2}/bin/ip -4 addr show tailscale0 | ${pkgs.gnugrep}/bin/grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    
    if [ -z "$TS_IP" ]; then
      echo "Error: Could not find Tailscale IP. Is Tailscale connected?"
      exit 1
    fi

    # そのIPでのみ待機する (家のWi-Fiの他人からは見えなくなる)
    echo "Starting WayVNC on $TS_IP..."
    nohup wayvnc --output="$HEADLESS_NAME" --max-fps=60 "$TS_IP" > /tmp/wayvnc.log 2>&1 &
    # ---------------------------------------------------------
  '';

  stop-ipad = pkgs.writeShellScriptBin "stop-ipad" ''
    echo "Stopping iPad screen..."
    pkill wayvnc
    hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | xargs -I{} hyprctl output remove {}
  '';
in
{
  # ipコマンドやgrepコマンドを使うので、依存パッケージに追加しておきます
  home.packages = [ start-ipad stop-ipad pkgs.jq pkgs.iproute2 pkgs.gnugrep ];
}
