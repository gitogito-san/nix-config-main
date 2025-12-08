{ config, pkgs, ... }:

{
  # 1. TLPと競合するサービスを確実に無効化 (Wikiの推奨事項)
  services.power-profiles-daemon.enable = false;
  # services.auto-cpufreq.enable = false; # 明示的に書かなくてもデフォルトfalseですが念の為

  # 2. TLPの有効化
  services.tlp = {
    enable = true;
    
    settings = {
      # --- CPU設定 (AMD Ryzen向け) ---
      # amd-pstate ドライバが有効な場合のパフォーマンス設定
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # CPUブースト設定 (AMD用)
      # バッテリー時はブーストを切って発熱と消費電力を抑える
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # --- プラットフォームプロファイル ---
      # 最近のハードウェア(ACPI)向けのプロファイル設定
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # --- その他 ---
      # Wi-Fiの省電力
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      # USB自動サスペンド (マウスなどがカクつく場合はブラックリストが必要)
      # 0 にすると無効化され、利便性が上がりますが電力消費は増えます
      USB_AUTOSUSPEND = 1; 
      
      # サスペンドからの復帰時にUSB機器をリセットしない（Bluetooth等のトラブル防止）
      USB_EXCLUDE_PHONE = 1;
    };
  };

  services.logind = {
    # 1. バッテリー駆動時: 安全のためサスペンド
    lidSwitch = "lock";
  };

  # 3. 計測用ツール (Powertop) の導入
  # 自動起動(enable=true)はせず、必要な時に手動で `sudo powertop` できるようにパッケージだけ入れる
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
