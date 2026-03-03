{ pkgs, ... }:
{
  home.packages = [
    pkgs.gvfs
    pkgs.samba
    pkgs.cifs-utils
    pkgs.sshfs
  ];

  xfconf.settings = {
    thunar = {
      "last-view" = "ThunarDetailsView";
      "last-details-view-zoom-level" = "THUNAR_ZOOM_LEVEL_38_PERCENT";
      "last-show-hidden" = false;
      "misc-single-click" = false;
    };
  };
}
