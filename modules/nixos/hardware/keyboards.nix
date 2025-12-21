{ ... }:

{
  services.udev.extraRules = ''
    # SayoDevice (ID: 8089)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="8089", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="8089", MODE="0666"

    # Corne v4 (ID: 4653)
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4653", MODE="0666"
    KERNEL=="hidraw*", ATTRS{idVendor}=="4653", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", MODE="0666"
  '';
}
