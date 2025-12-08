{ config, pkgs, ... }:

{
  # ly
#  services.displayManager.ly.enable = true;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Fcitx5
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      qt6Packages.fcitx5-configtool
    ];
    fcitx5.waylandFrontend = true;
  };

  # Fonts
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Hack Nerd Font Mono" "Noto Sans Mono CJK JP" ];
        sansSerif = [ "Hack Nerd Font" "Noto Sans CJK JP" ];
        serif = [ "Hack Nerd Font" "Noto Serif CJK JP" ];
      };
    };
    packages = with pkgs; [
      nerd-fonts.hack
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
  };
}
