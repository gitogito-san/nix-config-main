{ config, pkgs, ... }:

{
  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "nicoulaj";
      plugins = [
        "git"
        "sudo"
      ];
    };

    # Aliases
    shellAliases = {
      l = "ls -a";
      del = "clear";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#lifebook";
    };

    # Agenix
    initContent = ''
      if [ -f /run/agenix/copilotApiKey ]; then
        export COPILOT_API_KEY="$(cat /run/agenix/copilotApiKey)"
      fi

      if [ -f /run/agenix/geminiApiKey ]; then
        export GEMINI_API_KEY="$(cat /run/agenix/geminiApiKey)"
      fi
    '';
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
