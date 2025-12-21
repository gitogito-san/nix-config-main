{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      l = "ls -a";
      del = "clear";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#lifebook";
    };
    interactiveShellInit = ''
      if test -f /run/agenix/copilotApiKey
        set -gx COPILOT_API_KEY (cat /run/agenix/copilotApiKey)
      end

      if test -f /run/agenix/geminiApiKey
        set -gx GEMINI_API_KEY (cat /run/agenix/geminiApiKey)
      end

      set -g fish_greeting ""
    '';
  };
}
