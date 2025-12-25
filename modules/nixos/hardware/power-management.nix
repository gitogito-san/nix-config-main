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
      CPU_BOOST_ON_BAT = 1;

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      USB_AUTOSUSPEND = 0;
      USB_EXCLUDE_PHONE = 1;

      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "performance";

      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";

      RESTORE_DEVICE_STATE_ON_STARTUP = 0;
      DEVICES_TO_DISABLE_ON_STARTUP = "";
    };
  };

  boot.kernelParams = [
    "softlockup_panic=0"
    "nmi_watchdog=0"
    "usbcore.autosuspend=-1"
    "iommu=pt"
    "pcie_aspm=off"
  ];

  boot.extraModprobeConfig = ''
    options rtw89_pci disable_aspm=y
    options rtw89_core disable_ps_mode=y
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.thermald.enable = true;
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

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
