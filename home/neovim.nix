{ pkgs, ... }:
{
  home.packages = with pkgs; [ gcc ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      guess-indent-nvim
      indent-blankline-nvim
      gruvbox-nvim
      mini-nvim
      oil-nvim
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      mason-tool-installer-nvim
      fidget-nvim
      blink-cmp
      nvim-treesitter
    ];
    extraConfig = ''
      set nu rnu
      set bri udf ic scs
      set cul cc=80,120
      set ut=500
      set si ai 
      set sw=2 et
    '';
    extraLuaConfig = ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      vim.keymap.set('n', '<ESC>', '<cmd>noh<CR>')

      vim.keymap.set('n', '<C-h>', '<C-w>h')
      vim.keymap.set('n', '<C-j>', '<C-w>j')
      vim.keymap.set('n', '<C-k>', '<C-w>k')
      vim.keymap.set('n', '<C-l>', '<C-w>l')

      vim.keymap.set('n', '<leader>w', ':w<CR>')
      vim.keymap.set('n', '<leader>x', ':bd<CR>')

      vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
      vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
      vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
      vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')

      vim.keymap.set('v', '<', '<gv')
      vim.keymap.set('v', '>', '>gv')

      vim.keymap.set('n', 'S', '_diwP')
      vim.keymap.set('v', 'S', '_dp')

      vim.keymap.set('n', 'n', 'nzz')
      vim.keymap.set('n', 'N', 'Nzz')
      vim.keymap.set('n', '<C-d>', '<C-d>zz')
      vim.keymap.set('n', '<C-u>', '<C-u>zz')

      vim.keymap.set({ 'n', 'v' }, 'J', 'mzJ`z')

      vim.keymap.set('n', '<leader>ls', ':set syntax=')

      -------------------- COLOR SCHEME --------------------

      require('gruvbox').setup {
        disable_italics = true,
        disable_background = true,
        transparent_mode = true,
        italic = { strings = false, emphasis = false, comments = false }
      }

      vim.cmd.colorscheme 'gruvbox'
      vim.o.background = 'dark'

      -------------------- GUESS INDENT --------------------

      require('guess-indent').setup()

      -------------------- INDENT BLANKLINE --------------------

      require('ibl').setup()

      -------------------- MINI --------------------

      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup {
        mappings = { find = 'gs', add = 'ys', delete = 'ds', replace = 'cs' }
      }

      local statusline = require 'mini.statusline'
      statusline.setup()
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.pick').setup()

      vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
      vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')
      vim.keymap.set('n', '<leader>fg', ':Pick grep<CR>')
      vim.keymap.set('n', '<leader><leader>', ':Pick buffers<CR>')

      require('mini.jump2d').setup {
        allowed_windows = { not_current = false },
        mappings = { start_jumping = 's' }
      }

      -------------------- OIL --------------------

      require('oil').setup()

      vim.keymap.set('n', '<leader>e', ':Oil<CR>')
      vim.keymap.set('n', '<leader>fe', ':Oil --float<CR>')

      -------------------- BLINK --------------------

      require('blink.cmp').setup()

      -------------------- MASON --------------------

      require('mason').setup()

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local servers = {
        lua_ls = {}
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua'
      });
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('forcce', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end
        }
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nix-nvim-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, mode)
            vim.keymap.set(mode or 'n', keys, func)
          end
          map('gd', vim.lsp.buf.definition)
          map('gr', vim.lsp.buf.references)
          map('gI', vim.lsp.buf.implementation)
          map('gD', vim.lsp.buf.type_definition)
          map('<leader>lr', vim.lsp.buf.rename)
          map('<leader>la', vim.lsp.buf.code_action)
        end
      });

      -------------------- TREESITTER --------------------

      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'gitcommit', 'lua' },
        auto_install = false,
        parser_install_dir = vim.fn.stdpath('data') .. '/parsers'
      }
    '';
  };
}
