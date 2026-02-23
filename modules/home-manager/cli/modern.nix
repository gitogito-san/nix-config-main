{ pkgs, ... }:

{
  home.packages = [
    pkgs.bottom
    pkgs.bat
    pkgs.gemini-cli
    pkgs.ripgrep
    pkgs.dust
    pkgs.fastfetch
    pkgs.fd
    pkgs.ueberzugpp

    # PDF圧縮用スクリプト
    (pkgs.writeShellScriptBin "pdf-shrink" ''
      if [ -z "$1" ]; then
        echo "Usage: pdf-shrink input.pdf [output.pdf]"
        exit 1
      fi
      IN="$1"
      OUT="''${2:-compressed_''${IN}}"
      ${pkgs.ghostscript}/bin/gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$OUT" "$IN"
    '')
  ];

  programs = {

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    zellij.enable = true;

    pay-respects = {
      enable = true;
      enableFishIntegration = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
      flags = [ "--disable-up-arrow" ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    yazi = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  programs.fish.shellAbbrs = {
    cat = "bat";
    ls = "eza";
    tree = "eza --tree";
    cd = "z";
    grep = "rg";
    find = "fd";
    fetch = "fastfetch";
    fk = "pay-respects";
    zj = "zellij";

  };
}
