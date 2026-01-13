{ pkgs, ... }:
let
  inputImage = ./nahida.jpg;
in

{
  environment.systemPackages = [ pkgs.swww ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

    image = inputImage;

    polarity = "dark";

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
        applications = 16;
        terminal = 14;
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

    icons = {
      enable = true;

      package = pkgs.rose-pine-icon-theme;
      dark = "rose-pine";
      light = "rose-pine-dawn";
    };

  };

  environment.sessionVariables = {
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1.0";
  };
}
