{ pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    defaultEditor = false;

    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        idle-timeout = 0;
        default-yank-register = "+";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        color-modes = true;
        bufferline = "multiple";
        auto-save = true;
        whitespace.render = {
          space = "none";
          tab = "all";
          newline = "none";
          nbsp = "all";
        };
        whitespace.characters = {
          tab = "→";
          nbsp = "⍽";
        };
        statusline = {
          left = [
            "mode"
            "spinner"
          ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        file-picker = {
          hidden = false;
        };
      };
    };

    # LSP
    languages = {
      language-server = {
        nil = {
          command = "${pkgs.nil}/bin/nil";
          config.nil.nix.flake = {
            autoEvalInputs = true;
            autoArchive = true;
          };
        };
        typos = {
          command = "${pkgs.typos-lsp}/bin/typos-lsp";
        };
        rust-analyzer = {
          command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          config = {
            checkOnSave.command = "clippy";
            procMacro.enable = true;
          };
        };
        clangd = {
          command = "clangd";
          args = [
            "--header-insertion=never"
            "--background-index"
            "--query-driver=/nix/store/*-clang-*/bin/clang++,/nix/store/*-gcc-*/bin/g++,clang++,g++"
          ];
        };
        ruby-lsp = {
          command = "ruby-lsp";
        };
        pyright = {
          command = "pyright-langserver";
          args = [ "--stdio" ];
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
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
            command = "${pkgs.nixfmt}/bin/nixfmt";
          };
        }
        {
          name = "rust";
          auto-format = true;
          language-servers = [
            "rust-analyzer"
            "typos"
          ];
          formatter = {
            command = "${pkgs.rustfmt}/bin/rustfmt";
          };
        }
        {
          name = "c";
          auto-format = true;
          language-servers = [
            "clangd"
          ];
          formatter = {
            command = "clang-format";
          };
        }
        {
          name = "cpp";
          auto-format = true;
          language-servers = [
            "clangd"
            "typos"
          ];
          formatter = {
            command = "clang-format";
          };
        }
        {
          name = "ruby";
          auto-format = true;
          language-servers = [
            "ruby-lsp"
            "typos"
          ];
          formatter = {
            command = "rufo";
          };
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "pyright"
            "ruff"
            "typos"
          ];
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
          indent = {
            tab-width = 4;
            unit = "    ";
          };
        }
      ];
    };
  };

  # Packages
  home.packages = [
    pkgs.yt-dlp
    pkgs.ffmpeg
    pkgs.picard
  ];

}
