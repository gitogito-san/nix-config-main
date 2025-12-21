{ pkgs, ... }:

{
  home.packages = [
    pkgs.bottom
    pkgs.bat
    pkgs.gemini-cli
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.dust
    pkgs.fastfetch
    pkgs.fd
  ];

  programs = {
    git = {
      enable = true;
      settings = {
        user.name = "ya";
        user.email = "gitogitohub@gmail.com";
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
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

    delta = {
      enable = true;
      enableGitIntegration = true;
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    yazi.enable = true;
    yazi.enableFishIntegration = true;

  };

  programs.fish.shellAbbrs = {
    g = "git";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit -v";
    gcmsg = "git commit -m";
    gd = "git diff";
    gp = "git push";

    cat = "bat";
    ls = "eza";
    tree = "eza --tree";
    cd = "z";
    grep = "rg";
    find = "fd";
    lg = "lazygit";
    fetch = "fastfetch";
    zj = "zellij";
    fk = "pay-respects";
  };

}
