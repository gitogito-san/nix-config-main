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
      CPU_DRIVER_OPTS_ON_AC = "amd_pstate=active";
      CPU_DRIVER_OPTS_ON_BAT = "amd_pstate=active";
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "default";
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      USB_AUTOSUSPEND = 1;
      RUNTIME_PM_DENYLIST = "02:00.0";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelParams = [
    "amd_pstate=active"
    "resume=UUID=7bceb1ba-8c7c-4afa-a172-da2a029f7da3"
    "nmi_watchdog=0"
  ];

  boot.extraModprobeConfig = ''
    options rtw89_pci disable_aspm_l1=y disable_aspm_l1ss=y
  '';

  hardware.enableRedistributableFirmware = true;

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/7bceb1ba-8c7c-4afa-a172-da2a029f7da3";
    }
  ];

  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  security.pam.services.swaylock = { };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
    HandlePowerKey = "ignore";
  };

  environment.systemPackages = [
    pkgs.powertop
    pkgs.swaylock
    pkgs.wlogout
    pkgs.swayidle
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F200-3F29";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
      "noauto"
      "x-systemd.automount"
    ];
  };

  powerManagement.enable = true;

  powerManagement.powerDownCommands = ''
    ${pkgs.kmod}/bin/modprobe -r rtw89_8852ce || true
    ${pkgs.kmod}/bin/modprobe -r rtw89_pci || true
    ${pkgs.kmod}/bin/modprobe -r rtw89_core || true
  '';

  powerManagement.resumeCommands = ''
    ${pkgs.kmod}/bin/modprobe rtw89_core || true
    ${pkgs.kmod}/bin/modprobe rtw89_pci || true
    ${pkgs.kmod}/bin/modprobe rtw89_8852ce || true
  '';

}
