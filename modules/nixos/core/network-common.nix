{ pkgs, ... }:

{
  # Network Manager と VPNプラグイン (両方で必要)
  networking.networkmanager = {
    enable = true;
    plugins = [
      pkgs.networkmanager-l2tp
      pkgs.networkmanager-strongswan
    ];
  };

  # 必要なパッケージとサービス
  services.resolved.enable = true;
  services.strongswan.enable = true;
  services.xl2tpd.enable = true;
  environment.systemPackages = [
    pkgs.strongswan
    pkgs.xl2tpd
    pkgs.ethtool
  ];
  environment.etc."strongswan.conf".text = "";

  # Bluetooth (両方で使うと仮定)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Tailscale (基本機能のみ有効化)
  services.tailscale.enable = true;

  networking.firewall.checkReversePath = "loose";
  networking.firewall.allowedTCPPorts = [ 5600 ];
}
