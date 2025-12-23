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
