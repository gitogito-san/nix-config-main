{ pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
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
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          config = {
            checkOnSave = {
              command = "clippy";
            };
            procMacro = {
              enable = true;
            };
          };
        };
        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
        };
        ruby-lsp = {
          command = "${pkgs.ruby-lsp}/bin/ruby-lsp";
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [
            "nil"
            "typos"
          ];
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [
            "rust-analyzer"
            "typos"
          ];
        }
        {
          name = "c";
          auto-format = true;
          language-servers = [
            "clangd"
            "typos"
          ];
        }
        {
          name = "ruby";
          auto-format = true;
          language-servers = [
            "ruby-lsp"
            "typos"
          ];
        }
      ];
    };
  };

  # Packages
  home.packages = [
    pkgs.helix-gpt
    pkgs.nil
    pkgs.nixfmt-rfc-style
    pkgs.typos-lsp
  ];
}
