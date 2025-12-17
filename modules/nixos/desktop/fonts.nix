{ pkgs, ... }:
{
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