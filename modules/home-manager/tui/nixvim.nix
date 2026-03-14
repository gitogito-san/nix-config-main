{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # ==========================================
    # コア設定 (Core Settings)
    # ==========================================
    performance.byteCompileLua.enable = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      clipboard = "unnamedplus";
      ignorecase = true;
      smartcase = true;
      updatetime = 250;
      timeout = true;
      timeoutlen = 300;

      # [追加] LSPの警告が出た際に画面が横にガタつくのを防ぐ
      signcolumn = "yes";
      # [追加] 現在の行をハイライトして視認性を上げる
      cursorline = true;
    };

    extraConfigLua = ''
      vim.opt.shortmess:append("I")
    '';

    # ==========================================
    # 外部依存パッケージ (Dependencies)
    # ==========================================
    # [重要] Telescopeを正常に動かすための裏方バイナリを追加
    extraPackages = with pkgs; [
      wl-clipboard
      fd # find_files を爆速にするためのツール
      ripgrep # live_grep (文字列検索) を動かすために【必須】
    ];

    # ==========================================
    # プラグイン (Plugins)
    # ==========================================
    plugins = {
      # UI・操作補助
      lualine.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;

      # 構文解析
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # ファイラー
      oil = {
        enable = true;
        settings = {
          keymaps = {
            "q" = "actions.close";
          };
        };
      };

      # 検索エンジン (Telescope)
      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = {
            action = "find_files";
            options = {
              desc = "Find files";
            };
          };
          "<leader>/" = {
            action = "live_grep";
            options = {
              desc = "Live grep";
            };
          };
          "<leader>b" = {
            action = "buffers";
            options = {
              desc = "Find buffers";
            };
          };
        };
      };

      nvim-autopairs.enable = true;

      # インデントの縦線（タブ揃えの可視化）
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "▏";
          };
          scope = {
            enabled = true;
            char = "│";
          };
        };
      };

      bufferline.enable = true;

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = false; # 誰が書いたかの表示をオフ
          signs = {
            add = {
              text = "+";
            }; # 追加は +
            change = {
              text = "~";
            }; # 変更は ~
            delete = {
              text = "-";
            }; # 削除は -
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
          };
        };
      };

      nvim-surround.enable = true;

      flash.enable = true;
    };

    # ==========================================
    # カスタムキーバインド (Keymaps)
    # ==========================================
    keymaps = [
      # ---------------------------------------------------
      # Space メニュー (Helixスタイルを再現)
      # ---------------------------------------------------

      # [f, b, /] 検索系 (すでに設定済みなら上書き・確認)
      {
        mode = "n";
        key = "<leader>f";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Open file picker";
        };
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "Open buffer picker";
        };
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "Global search in workspace";
        };
      }

      # [w] ウィンドウ操作 (Vim標準の <C-w> プレフィックスを割り当て)
      {
        mode = "n";
        key = "<leader>w";
        action = "<C-w>";
        options = {
          desc = "Window";
        };
      }

      # [c] コメントアウト (Neovim標準の gc コマンドを呼び出す)
      {
        mode = "n";
        key = "<leader>c";
        action = "gcc";
        options = {
          desc = "Comment/uncomment selection";
          remap = true;
        };
      }
      {
        mode = "v";
        key = "<leader>c";
        action = "gc";
        options = {
          desc = "Comment/uncomment selection";
          remap = true;
        };
      }

      # [q] Oilファイラー（先ほどのマイナスキーの代わりに、あえてSpaceメニューに入れるなら）
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Oil<CR>";
        options = {
          desc = "Open file explorer";
        };
      }

      # ---------------------------------------------------
      # 以下は、この後「LSP（言語サーバー）」を入れると動くようになる予約枠
      # ---------------------------------------------------
      # { mode = "n"; key = "<leader>k"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options = { desc = "Show docs for item under cursor"; }; }
      # { mode = "n"; key = "<leader>r"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options = { desc = "Rename symbol"; }; }
      # { mode = "n"; key = "<leader>a"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options = { desc = "Perform code action"; }; }
      # { mode = "n"; key = "<leader>d"; action = "<cmd>Telescope diagnostics<CR>"; options = { desc = "Open diagnostic picker"; }; }
    ];
  };
}
