{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = [ "gtk" ];
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
