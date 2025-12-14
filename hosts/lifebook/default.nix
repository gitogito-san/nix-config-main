{ config, pkgs, ... }:

{
  imports = [
    # 1. ハードウェア設定 (同じフォルダ)
    ./hardware-configuration.nix

    # 2. システム共通設定 (さっき作ったファイル)
    ../../modules/core/system.nix
    ../../modules/core/power-management.nix
    ../../modules/gui.nix  
    
   ];

  # --- Host Specific Settings ---
  networking.hostName = "lifebook"; # ホスト名はここに書く

  # --- Users ---
  users.users.ya = {
    isNormalUser = true;
    description = "ya";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };
  # システムレベルでzshを有効化
  programs.zsh.enable = true;

  # --- System Packages (このPCで必要なもの) ---
  environment.systemPackages = with pkgs; [
    git
    # vim # 必要なら
  ];

  # --- Hardware/Device Specific Rules ---
  # キーボードの設定などはハードウェアに依存するのでここに残してOK
  services.udev.extraRules = ''
    # SayoDevice (ID: 8089)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="8089", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="8089", MODE="0666"
    # Corne v4 (ID: 4653)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4653", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", MODE="0666"
  '';
  
  hardware.enableRedistributableFirmware = true;

  # 変更しないこと
  system.stateVersion = "25.11";
}
