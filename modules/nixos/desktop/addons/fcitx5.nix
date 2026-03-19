{ pkgs, ... }:
{

  nixpkgs.overlays = [
    (final: prev: {
      mozcdic-ut = prev.mozcdic-ut.overrideAttrs (old: {
        neologdSrc = final.fetchFromGitHub {
          owner = "utuhiro78";
          repo = "mozcdic-ut-neologd";
          rev = "master";
          sha256 = "sha256-S7JfsTRiGWoheowKN+6E6qyX/aTWALDMifgpWIh+EeY=";
        };

        postPatch = (old.postPatch or "") + ''
          echo "Injecting NEologd dictionary..."

          sed -i 's/#neologd="true"/neologd="true"/g' src/merge/make.sh

          cp -r $neologdSrc src/merge/mozcdic-ut-neologd
          chmod -R +w src/merge/mozcdic-ut-neologd
        '';
      });

    })
  ];
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = [
      pkgs.fcitx5-mozc-ut
      pkgs.fcitx5-gtk
      pkgs.qt6Packages.fcitx5-configtool
    ];
    fcitx5.waylandFrontend = true;
  };
}
