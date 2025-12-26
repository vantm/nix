vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<ESC>', '<cmd>noh<CR>')

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>x', '<C-w>q')

vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')

vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', 'S', '"_diwP')
vim.keymap.set('v', 'S', '"_dp')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set({ 'n', 'v' }, 'J', 'mzJ`z')

vim.keymap.set('n', '<leader>ls', ':set syntax=')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('nvim-lsp-format', { clear = true }),
  callback = function()
    local map = function(keys, func, mode)
      vim.keymap.set(mode or 'n', keys, func)
    end
    map('gd', vim.lsp.buf.definition)
    map('gr', vim.lsp.buf.references)
    map('gI', vim.lsp.buf.implementation)
    map('gD', vim.lsp.buf.type_definition)
    map('<leader>lr', vim.lsp.buf.rename)
    map('<leader>lf', vim.lsp.buf.format)
    map('<leader>la', vim.lsp.buf.code_action)
  end
});

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
    },
  },
  'j-hui/fidget.nvim',
  'saghen/blink.cmp',
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
