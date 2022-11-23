-- :help nvim_set_keymap()

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Better escape using jk in insert and terminal mode
keymap('i', 'jk', '<ESC>', default_opts)
keymap('t', 'jk', '<C-\\><C-n>', default_opts)
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', default_opts)
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', default_opts)
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', default_opts)
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', default_opts)

-- Center search results
keymap('n', 'n', 'nzz', default_opts)
keymap('n', 'N', 'Nzz', default_opts)

-- Visual line wraps
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap('v', '<', '<gv', default_opts)
keymap('v', '>', '>gv', default_opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', default_opts)
keymap('v', '<A-k>', ':m .-2<CR>==', default_opts)

-- Retain clipboard contents after paste
keymap('v', 'p', '"_dP', default_opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<CR>', default_opts)
keymap('n', '<C-Down>', ':resize -2<CR>', default_opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', default_opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', default_opts)

-- buffers
keymap('n', '<S-l>', ':bnext<CR>', default_opts)
keymap('n', '<S-h>', ':bprevious<CR>', default_opts)

keymap('n', '<leader>w', '<cmd>w<CR>', default_opts)
keymap('n', '<leader>W', '<cmd>w!<CR>', default_opts)
keymap('n', '<leader>q', '<cmd>q<CR>', default_opts)
keymap('n', '<leader>Q', '<cmd>q!<CR>', default_opts)
keymap('n', '<leader>c', ':Bdelete<CR>', default_opts)
keymap('n', '<leader>C', ':Bdelete<CR>', default_opts)

keymap('n', '<C-s>', '<cmd>w!<CR>', default_opts)
keymap('n', '<C-q>', '<cmd>q!<CR>', default_opts)

-- Clear search highlight
keymap('n', '<leader><leader>', ':nohlsearch<Bar>:echo<CR>', default_opts)
keymap('n', '<esc>', ':nohlsearch<Bar>:echo<CR>', default_opts)

-- Nvimtree
keymap('n', '<leader>e', '<cmd>Neotree toggle<CR>', default_opts)

-- Comment
-- keymap("v", "gc", ":lua require(\"Comment.api\").gc(vim.fn.visualmode())<cr>", opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)
