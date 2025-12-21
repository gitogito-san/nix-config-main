{ pkgs, ... }:
{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Hack Nerd Font Mono"
          "Noto Sans Mono CJK JP"
        ];
        sansSerif = [
          "Hack Nerd Font"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Hack Nerd Font"
          "Noto Serif CJK JP"
        ];
      };
    };
    packages = [
      pkgs.nerd-fonts.hack
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif
    ];
  };
}
