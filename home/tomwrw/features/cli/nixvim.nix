{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # The original config had gcc here. We'll keep it for utility.
  home.packages = with pkgs; [
    gcc
  ];

  programs.nixvim = {
    enable = true;

    # --- Core Settings (From init.lua) ---
    defaultEditor = true;
    globals.mapleader = " ";
    globals.maplocalleader = ","; # Added for consistency

    # Omarchy uses 'catppuccin-mocha' as its colorscheme
    # We will use the nixvim's catppuccin plugin instead of base16.

    # Disable your old colorscheme settings
    #colorschemes.base16.enable = lib.mkForce true;

    colorschemes.base16 = {
      enable = true;
      autoLoad = true;
      # 3. Reference the color set provided by Stylix (required for Stylix integration)
      colorscheme = config.stylix.base16Scheme;
      #colorscheme = lib.mapAttrs (name: value: "#${value}") config.stylix.base16Scheme;
    };

    # ... (Rest of your Omarchy config remains below) ...

    # The colorscheme option in `programs.nixvim` should be set to "base16"
    colorscheme = "base16";

    # --- Vim Options (From lua/config/options.lua) ---
    opts = {
      encoding = "utf-8";
      fileencoding = "utf-8";
      #termguicolors = true;
      number = true;
      relativenumber = true;
      mouse = "a";
      title = true;
      cursorline = true;
      expandtab = true;
      shiftwidth = 4; # Omarchy uses 4
      tabstop = 4; # Omarchy uses 4
      softtabstop = 4;
      autoindent = true;
      smartindent = true;
      wrap = false;
      # Search settings
      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;
      # Window/UI
      splitbelow = true;
      splitright = true;
      signcolumn = "yes";
      conceallevel = 0;
      undofile = true;
      backup = false;
      swapfile = false;
      # Timeouts
      timeout = true;
      timeoutlen = 500; # Omarchy uses 500
      updatetime = 300; # Omarchy uses 300
      # Clipboard
      clipboard = "unnamedplus";
    };

    # --- Plugins (From lua/plugins/*.lua) ---
    plugins = {
      # File/Tree/Buffer Management
      oil.enable = true;
      bufferline.enable = true;
      nvim-tree.enable = true; # Omarchy uses NvimTree, not in your old config

      # Completion/LSP
      cmp = {
        enable = true;
        autoEnableSources = true;
        # Omarchy's mappings are largely default but customized for Tab/CR
        settings = {
          mapping = {
            # Use defaults from Omarchy's keymaps for <C-n>, <C-p>, <C-y>
            "<CR>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })";
          };
        };
      };
      lsp = {
        enable = true;
        # Omarchy uses a separate lsp-config setup, we'll keep your server list and add key plugins
        servers = {
          # Keep your server list as it's comprehensive
          ts_ls.enable = true;
          cssls.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          clangd.enable = true;
          rust_analyzer.enable = true;
          lua_ls.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          yamlls.enable = true; # Added from your commented line/expected plugins
        };
        # Omarchy uses lsp-zero for setup; we'll add its diagnostic settings.
      };

      # Utility
      lualine.enable = true;
      gitsigns.enable = true;
      transparent.enable = false; # Omarchy does not use transparent
      telescope.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
      trouble.enable = true;
      conform-nvim = {enable = true;}; # Omarchy uses null-ls/none-ls, but conform is modern

      # Omarchy-specific plugins (Replacing your older selection where needed)
      neogit.enable = true; # Keeping neogit
      fugitive.enable = true; # Keeping fugitive
      git-conflict.enable = true;
      # Omarchy uses 'lsp-zero' (not needed with native nixvim LSP)
      # Omarchy uses 'comment.nvim' (not defined in your config, adding it)
      #comment-nvim.enable = true;
      # Omarchy uses 'tokyonight' for the theme (already handled with catppuccin)

      # Keep your domain-specific plugins
      vimtex.enable = true;
      helm.enable = true;
      render-markdown.enable = true;
      wakatime.enable = true;
      illuminate.enable = true; # Keeping illuminate

      # Remove haskell-tools-nvim (it's often better to rely on lsp + extraConfigLua for HLS)
    };

    # --- Keymaps (Translated from Omarchy's lua/keymaps.lua) ---
    keymaps = [
      # Leader + f (Find files, live grep, buffers)
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
        mode = "n";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
        mode = "n";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
        mode = "n";
      }

      # Leader + g (Git)
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>gg";
        mode = "n";
      }
      {
        action = "<cmd>Gitsigns next_hunk<CR>";
        key = "[g";
        mode = "n";
      }
      {
        action = "<cmd>Gitsigns prev_hunk<CR>";
        key = "]g";
        mode = "n";
      }

      # LSP
      {
        action = "<cmd>TroubleToggle<CR>";
        key = "<leader>d";
        mode = "n";
      } # Use Trouble
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>ca";
        mode = "n";
      }
      {
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        key = "<leader>cf";
        mode = "n";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "gd";
        mode = "n";
      }
      {
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        key = "gr";
        mode = "n";
      }
      {
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        key = "K";
        mode = "n";
      }

      # Window/Split Navigation (From Omarchy)
      {
        action = "<C-h>";
        key = "<C-h>";
        mode = "n";
      }
      {
        action = "<C-j>";
        key = "<C-j>";
        mode = "n";
      }
      {
        action = "<C-k>";
        key = "<C-k>";
        mode = "n";
      }
      {
        action = "<C-l>";
        key = "<C-l>";
        mode = "n";
      }

      # Window/Split Resizing (From Omarchy)
      {
        action = "<C-w><lt>";
        key = "<M-left>";
        mode = "n";
      }
      {
        action = "<C-w>>";
        key = "<M-right>";
        mode = "n";
      }
      {
        action = "<C-w>+";
        key = "<M-up>";
        mode = "n";
      }
      {
        action = "<C-w>-";
        key = "<M-down>";
        mode = "n";
      }

      # Terminal
      {
        action = "<cmd>term<CR>";
        key = "<leader>tt";
        mode = "n";
      }

      # Misc
      {
        action = "<cmd>Oil<CR>";
        key = "-";
        mode = "n";
      } # Keeping your file explorer
      {
        action = "gt";
        key = "<C-t>";
        mode = "n";
      } # Omarchy tab next
      {
        action = "gT";
        key = "<C-S-t>";
        mode = "n";
      } # Omarchy tab prev

      # Commenting (Requires comment-nvim)
      {
        action = "gcc";
        key = "<leader>/";
        mode = "n";
      }
      {
        action = "gc";
        key = "<leader>/";
        mode = "v";
      }

      # Omarchy uses <C-o> for tab navigation, so we are keeping it as is
      # { action = "<cmd>tabnext<CR>"; key = "<C-o>"; mode = "n"; }
    ];

    # --- Lua/Vim Custom Configuration ---
    # Omarchy has very little custom vimscript, mostly focusing on Lua.
    # We will mostly remove your old extraConfigVim and keep the haskell-tools part as a starting point.
    extraConfigVim = lib.mkForce ''
      " Omarchy style minimal vimscript
      set shellcmdflag=-ic
      set shortmess+=W

      " Keep selection after indent
      vnoremap < <gv
      vnoremap > >gv

      " Map F2/F3 for session management (keeping your existing bindings)
      map <F2> :mksession! ~/vim_session <cr>
      map <F3> :source ~/vim_session <cr>

      " Your kitty padding commands (keeping them)
      augroup kitty_mp
        autocmd!
        au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=4
        au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
      augroup END

      " Your EJS/clipboard settings (keeping them)
      au BufNewFile,BufRead *.ejs set filetype=html
      set clipboard=unnamed
    '';

    # We remove your old Haskell-tools lua config and rely on the new LSP setup
    extraConfigLua = lib.mkForce "";

    # Additional Omarchy preferences to match
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
