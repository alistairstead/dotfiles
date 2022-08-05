local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

vim.g.mapleader = ' '
map('i', 'jk', '<esc>', {noremap = true})
map('n', '<leader><leader>', ':nohlsearch<cr>', default_opts)
map("n", "<esc>", ":nohlsearch<CR>", default_opts)

map('n', '<leader>ve', ':edit ~/.config/nvim<cr>', default_opts)
map('n', '<leader>vr', ':source ~/.config/nvim/init.lua <cr>', default_opts)

-- Keep visual selection after move
map('v', '<', '<gv', {noremap = true})
map('v', '>', '>gv', {noremap = true})

require('keymappings.tabs')
require('keymappings.splits')
require('keymappings.buffers')
require('keymappings.filenav')
