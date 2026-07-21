{ ... }:

{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      del = "clear";
      update-local = "pushd ~/nix-config && git pull && sudo nixos-rebuild switch --flake . && popd";
      deploy-server = "deploy .#trigkey";
      ssh-sol = "autossh -M 0 sol";
      ssh-ced = "autossh -M 0 ced";
      wake-pc = "wakeonlan FC:9D:05:30:D3:C6";
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
