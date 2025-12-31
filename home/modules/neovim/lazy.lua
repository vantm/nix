require('lazy').setup {
  'NMAC427/guess-indent.nvim',
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        disable_italics = true,
        disable_background = true,
        transparent_mode = true,
        italic = { strings = false, emphasis = false, comments = false }
      }
      vim.cmd.colorscheme 'gruvbox'
      vim.o.background = 'dark'
    end
  },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      require('mini.surround').setup {
        mappings = {
          find = 'gs', add = 'ys', delete = 'ds', replace = 'cs',
          find = '', find_left = '', highlight = ''
        }
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
    end
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      label = { style = 'inline' },
      highlight = { backdrop = false },
      modes = {
        char = { highlight = { backdrop = false }, },
      },
    },
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end },
      { 'B', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end },
    },
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
      vim.keymap.set('n', '<leader>e', ':Oil<CR>')
      vim.keymap.set('n', '<leader>fe', ':Oil --float<CR>')
    end
  },
  {
    'mistweaverco/kulala.nvim',
    ft = { 'http', 'rest' },
    opts = {
      global_keymaps = true,
      lsp = { keymaps = true, },
      ui = { max_response_size = 1048576, },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "omnisharp-extended-lsp.nvim"
    },
  },
  'j-hui/fidget.nvim',
  {
    'saghen/blink.cmp',
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'normal' },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "lua" }
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'gitcommit', 'lua' },
      auto_install = true,
      highlight = { enable = true, },
      indent = { enable = true }
    }
  },
}
