{ ... }:

{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      l = "eza -a";
      del = "clear";
      update = "pushd ~/nix-config && git pull && sudo nixos-rebuild switch --flake . && popd";
    };
    functions = {
      ytdl = ''
        yt-dlp \
          --extract-audio \
          --audio-format m4a \
          --embed-thumbnail \
          --embed-metadata \
          --parse-metadata "title:%(artist)s - %(title)s" \
          --output "%(title)s.%(ext)s" \
          $argv
      '';
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
