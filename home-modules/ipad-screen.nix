{ config, pkgs, ... }:

let
  start-ipad = pkgs.writeShellScriptBin "start-ipad" ''
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

    echo "Monitor created: $HEADLESS_NAME"

    hyprctl keyword monitor "$HEADLESS_NAME, 1920x1080, 2560x0, 1"

    TS_IP=$(${pkgs.iproute2}/bin/ip -4 addr show tailscale0 | ${pkgs.gnugrep}/bin/grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    
    if [ -z "$TS_IP" ]; then
      echo "Error: Could not find Tailscale IP. Is Tailscale connected?"
      exit 1
    fi

    echo "Starting WayVNC on $TS_IP..."
    nohup wayvnc --output="$HEADLESS_NAME" --max-fps=60 "$TS_IP" > /tmp/wayvnc.log 2>&1 &
  '';

  stop-ipad = pkgs.writeShellScriptBin "stop-ipad" ''
    echo "Stopping iPad screen..."
    pkill wayvnc
    hyprctl -j monitors | ${pkgs.jq}/bin/jq -r '.[] | select(.name | startswith("HEADLESS")) | .name' | xargs -I{} hyprctl output remove {}
  '';
in
{
  home.packages = [ start-ipad stop-ipad pkgs.jq pkgs.iproute2 pkgs.gnugrep ];
}
