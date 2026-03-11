{ pkgs, lib, ... }:

let
  hackedCustomCursor = pkgs.stdenv.mkDerivation {
    pname = "hacked-cursor-black";
    version = "1.0";

    src = pkgs.fetchzip {
      # URLの末尾を dl=1 に変更し、直接ダウンロードを強制する
      url = "https://www.dropbox.com/scl/fi/au99ozxjuo74yot/Hacked-Black.tgz?rlkey=vsbtxjvqb6ubq9ml175tyso1x&dl=1";
      extension = "tgz"; # ← これを追加して拡張子を強制認識させる
      # 初回は意図的にダミーハッシュを指定してエラーを起こす
      hash = "sha256-LJseClgoQ5C4x0z3CCTAVoh4NOb87rAnmF+1G0RYU7U=";
    };

    installPhase = ''
      # Nixストア内にアイコンの標準パスを作成
      mkdir -p $out/share/icons/Hacked-Black

      # 展開された中身をすべてコピー
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
