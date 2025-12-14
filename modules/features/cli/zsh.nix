{ config, pkgs, ... }:

{
  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    
    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "nicoulaj";
      plugins = [ "git" "sudo" ];
    };

    # Aliases
    shellAliases = {
      sd = "sudo";
      l = "ls -a";
      del = "clear";
      update = "sudo nixos-rebuild switch --flake /etc/nixos";
      gemini = "npx @google/gemini-cli";
    };
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "ya";
      user.email = "gitogitohub@gmail.com";
    };
  };
  
  # Direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
