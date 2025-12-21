{ pkgs, ... }:

{
  # PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.rtkit.enable = true;

  # packages
  environment.systemPackages = [
    pkgs.sof-firmware
    pkgs.alsa-utils
    pkgs.pavucontrol
  ];
}
