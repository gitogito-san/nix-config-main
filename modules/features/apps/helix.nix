{ config, pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "jellybeans";
      editor = {
        line-number = "relative";
        cursorcolumn = true;
        true-color = true;
        idle-timeout = 0;
        clipboard-provider = "wayland";
        default-yank-register = "+";
        };
    };

  # LSP
  languages = {
      language-server.gpt = {
        command = "helix-gpt";
        args = [ "--handler" "copilot" ]; 
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" ];
        }
      ];
    };
  };

  # Packages
  home.packages = with pkgs; [
    helix-gpt
    nil
    typos-lsp
  ];
}
