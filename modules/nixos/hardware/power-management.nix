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
      PCIE_ASPM_ON_BAT = "powersupersave";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      USB_AUTOSUSPEND = 1;
    };
  };

  boot.kernelParams = [
    "amd_pstate=active"
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
    HandleLidSwitch = "suspend-then-hibernate";
    HandleLidSwitchExternalPower = "lock";
    HandleLidSwitchDocked = "ignore";
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=2h
  '';

  environment.systemPackages = [
    pkgs.powertop
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

}
