{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.firefox
    pkgs.google-chrome
    inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
    pkgs.discord
    pkgs.vial
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
  };

}
