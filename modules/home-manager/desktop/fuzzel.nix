{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        width = 40;
      };
    };
  };

  home.packages = [
    (pkgs.makeDesktopItem {
      name = "classroom";
      desktopName = "Classroom";
      exec = "firefox https://classroom.google.com/u/2/";
      icon = "firefox";
      categories = [ "Education" ];
    })
    (pkgs.makeDesktopItem {
      name = "webclass";
      desktopName = "WebClass";
      exec = "firefox https://webclass.cdel.uec.ac.jp/webclass/";
      icon = "firefox";
      categories = [ "Education" ];
    })
    (pkgs.makeDesktopItem {
      name = "lms";
      desktopName = "LMS";
      exec = "firefox https://lms.edu.uec.ac.jp/";
      icon = "firefox";
      categories = [ "Education" ];
    })
    (pkgs.makeDesktopItem {
      name = "moodle";
      desktopName = "Moodle";
      exec = "firefox https://joho.g-edu.uec.ac.jp/moodle3/";
      icon = "firefox";
      categories = [ "Education" ];
    })
  ];

}
