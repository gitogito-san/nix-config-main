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
          config.nil.nix.flake = {
            autoEvalInputs = true;
            autoArchive = true;
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
            checkOnSave.command = "clippy";
            procMacro.enable = true;
          };
        };
        clangd = {
          command = "${pkgs.clang-tools}/bin/clangd";
        };
        ruby-lsp = {
          command = "ruby-lsp";
          config = {
            bundleGemfile = "";
          };
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
          formatter = {
            command = "${pkgs.rustfmt}/bin/rustfmt";
          };
        }
        {
          name = "c";
          auto-format = true;
          language-servers = [
            "clangd"
            "typos"
          ];
          formatter = {
            command = "${pkgs.clang-tools}/bin/clang-format";
          };
        }
        {
          name = "ruby";
          auto-format = true;
          language-servers = [
            "ruby-lsp"
          ];
          formatter = {
            command = "${pkgs.rufo}/bin/rufo";
            args = [ "-p" ];
          };
        }
      ];
    };
  };

  # Packages
  home.packages = [
  ];

}
