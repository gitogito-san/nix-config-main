{ config, pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "jellybeans";
      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        idle-timeout = 0;
        clipboard-provider = "wayland";
        default-yank-register = "+";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
      };
    };

    # LSP
    languages = {
      language-server = {
        nil = {
          command = "${pkgs.nil}/bin/nil";
          config = {
            nil = {
              nix.flake = {
                autoEvalInputs = true;
                autoArchive = true;
              };
              formatting = {
                command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
              };
            };
          };
        };
        gpt = {
          command = "${pkgs.helix-gpt}/bin/helix-gpt";
          args = [
            "--handler"
            "copilot"
          ];
        };
        typos = {
          command = "${pkgs.typos-lsp}/bin/typos-lsp";
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [
            "typos"
            "nil"
          ];
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
        {
          name = "rust";
          # 将来的に  [ "typos" "rust-analyzer" "gpt" ] にする
          language-servers = [
            "typos"
            "gpt"
          ];
          auto-format = true;
        }
      ];
    };
  };

  # Packages
  home.packages = with pkgs; [
    helix-gpt
    nil
    typos-lsp
    nixfmt-rfc-style
  ];
}
