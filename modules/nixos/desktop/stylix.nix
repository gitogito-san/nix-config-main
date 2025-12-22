{ pkgs, lib, ... }:
let
  inputImage = ./nahida.jpg;
  brightness = "-15";
  contrast = "0";
  fillColor = "black";
in

{
  environment.systemPackages = [ pkgs.swww ];

  stylix = {
    enable = true;

    # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";

    image = pkgs.runCommand "dimmed-background.png" { } ''
      ${lib.getExe' pkgs.imagemagick "convert"} "${inputImage}" -brightness-contrast ${brightness},${contrast} -fill ${fillColor} $out
    '';

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
        applications = 12;
        terminal = 10;
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
