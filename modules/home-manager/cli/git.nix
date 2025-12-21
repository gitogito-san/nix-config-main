{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "ya";
      email = "gitogitohub@gmail.com";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  home.packages = [
    pkgs.lazygit
    pkgs.gh
  ];

  programs.fish.shellAbbrs = {
    g = "git";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit -v";
    gcmsg = "git commit -m";
    gp = "git push";
    lg = "lazygit";
  };
}
