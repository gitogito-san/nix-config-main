{ pkgs, ... }:

{
  # Network Manager
  networking.networkmanager = {
    enable = true;
    plugins = [
      pkgs.networkmanager-l2tp
      pkgs.networkmanager-strongswan
    ];
  };

  services.resolved.enable = true;

  services.strongswan.enable = true;
  services.xl2tpd.enable = true;
  environment.systemPackages = [
    pkgs.strongswan
    pkgs.xl2tpd
    pkgs.ethtool
  ];
  environment.etc."strongswan.conf".text = "";

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

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
          ${pkgs.ethtool}/bin/ethtool -K "$IFACE" rx-udp-gro on || echo "rx-udp-gro not supported, skipping."
          ${pkgs.ethtool}/bin/ethtool -K "$IFACE" tx-udp-segmentation on || echo "tx-udp-segmentation not supported, skipping."
        else
          echo "Device $IFACE not found, skipping optimization."
        fi
      '';
      RemainAfterExit = true;
    };
  };

  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 5600 ];
}
