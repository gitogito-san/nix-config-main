{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/core/default.nix # メイン機の共通設定（ユーザー、タイムゾーン等）を流用
  ];

  # --- ブートローダーの設定 ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- ホスト名 ---
  networking.hostName = "trigkey";

  # --- ネットワークとセキュリティ（Tailscale特化） ---
  networking.networkmanager.enable = true;

  # Tailscaleを有効化
  services.tailscale.enable = true;

  # SSHを有効化
  services.openssh = {
    enable = true;
    # よりセキュアにするなら、鍵認証の確認後に以下を false に設定します
    # settings.PasswordAuthentication = false;
  };

  # ファイアウォールの設定（超重要）
  networking.firewall = {
    enable = true;
    # Tailscaleからの通信を「身内」として全許可
    trustedInterfaces = [ "tailscale0" ];

    # 外部のインターネットや、Tailscaleを通さない大学のWi-Fi等からの直接アクセスは全て遮断
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ ];
  };

  # サーバーとしての不要パッケージ削減（軽量化）
  environment.defaultPackages = [ ];
  services.xserver.enable = false; # GUIの完全無効化

  # Masterの指定通り、最新stableバージョンを設定
  system.stateVersion = "25.11";

  users.users.ya = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQudxqP1y+lmBwCpPE+JkpdVHK9FPw8n0IibALGEbwL ya@nixos"
    ];
  };
}
