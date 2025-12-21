{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.swww ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

    image = ./nahida.jpg;

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-serif;
        name = "Noto Serif CJK JP";
      };
      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font Mono";
      };

      sizes = {
        applications = 11;
        terminal = 11;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

  };
}
