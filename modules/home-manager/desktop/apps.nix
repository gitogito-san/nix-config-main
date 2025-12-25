{ pkgs, ... }:

{
  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
    pkgs.discord
    pkgs.vial
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };

}
