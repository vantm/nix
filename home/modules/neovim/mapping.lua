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
  group = vim.api.nvim_create_augroup('neovim-lsp-mappings', { clear = true }),
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
