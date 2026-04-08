{ pkgs, ... }:

{
  # Tailscale を Subnet Router として動作させる
  services.tailscale.useRoutingFeatures = "server";

  # UEC-VPN の強制自動接続
  systemd.services.uec-vpn-autostart = {
    description = "Auto-connect UEC-VPN on boot";
    wants = [ "network-online.target" ];
    after = [
      "network-online.target"
      "NetworkManager.service"
    ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.networkmanager}/bin/nmcli connection up "UEC-VPN" || true
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # UEC-VPN の死活監視 (1分間隔)
  systemd.services.uec-vpn-monitor = {
    description = "Monitor and Reconnect UEC-VPN";
    after = [ "uec-vpn-autostart.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      while true; do
        if ! ${pkgs.iproute2}/bin/ip link show ppp0 > /dev/null 2>&1; then
          echo "UEC-VPN is down. Attempting to reconnect..."
          ${pkgs.networkmanager}/bin/nmcli connection up "UEC-VPN" || true
        fi
        sleep 60
      done
    '';
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "10";
    };
  };

  # Tailscale用ネットワーク最適化 (enp1s0 決め打ち)
  systemd.services.tailscale-gro-optimize = {
    description = "Tailscale UDP GRO optimization";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "tailscale-gro-fix" ''
        IFACE="enp1s0"
        if [ -d "/sys/class/net/$IFACE" ]; then
          echo "Optimizing $IFACE for Tailscale..."
          ${pkgs.ethtool}/bin/ethtool -K "$IFACE" rx-udp-gro on || echo "rx-udp-gro not supported"
          ${pkgs.ethtool}/bin/ethtool -K "$IFACE" tx-udp-segmentation on || echo "tx-udp-segmentation not supported"
        fi
      '';
      RemainAfterExit = true;
    };
  };
}
