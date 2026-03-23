{ pkgs, ... }:

let
  hackedCustomCursor = pkgs.stdenv.mkDerivation {
    pname = "hacked-cursor-black";
    version = "1.0";

    src = pkgs.fetchzip {
      url = "https://www.dropbox.com/scl/fi/au99ozxjuo74yot/Hacked-Black.tgz?rlkey=vsbtxjvqb6ubq9ml175tyso1x&dl=1";
      extension = "tgz";
      hash = "sha256-LJseClgoQ5C4x0z3CCTAVoh4NOb87rAnmF+1G0RYU7U=";
    };

    installPhase = ''
      mkdir -p $out/share/icons/Hacked-Black
      cp -r * $out/share/icons/Hacked-Black/
    '';
  };
in
{
  home.pointerCursor = {
    package = hackedCustomCursor;
    name = "Hacked-Black";
    size = 28;
    gtk.enable = true;
    x11.enable = true;
  };

  wayland.windowManager.hyprland.settings.env = [
    "XCURSOR_THEME,Hacked-Black"
    "XCURSOR_SIZE,28"
    "HYPRCURSOR_THEME,Hacked-Black"
    "HYPRCURSOR_SIZE,28"
  ];
}
