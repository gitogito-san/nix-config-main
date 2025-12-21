{ pkgs, ... }:

{
  # counter TLP conflict
  systemd.services.NetworkManager-wait-online.enable = false;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = false;

  # TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_PHONE = 1;

      PCIE_ASPM_ON_AC = "performance";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      DEVICES_TO_DISABLE_ON_STARTUP = "";
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  # packages
  environment.systemPackages = [
    pkgs.powertop
  ];

  fileSystems."/boot" = {
    options = [
      "umask=0077"
      "noauto"
      "x-systemd.automount"
    ];
  };

  security.pam.services.swaylock = { };
}
