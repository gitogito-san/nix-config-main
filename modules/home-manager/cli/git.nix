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
    gaa = "git add -A";
    gc = "git commit -m";
    gsw = "git switch";
    gsc = "git switch -c";
    gp = "git push";
    gl = "git pull";
    gst = "git status";
    gd = "git diff";
    glog = "git log --oneline --graph --decorate --all";
    lg = "lazygit";
  };
}
