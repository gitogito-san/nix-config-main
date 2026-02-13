{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = [
    pkgs.nwg-displays
    pkgs.wlr-randr
  ];

  home.activation = {
    createMonitorConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -f "${config.home.homeDirectory}/.config/hypr/monitors.conf" ]; then
        echo "Creating mutable monitor config file..."
        touch "${config.home.homeDirectory}/.config/hypr/monitors.conf"
      fi
    '';
  };
}
