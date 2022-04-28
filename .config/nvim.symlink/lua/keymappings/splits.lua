local map = vim.api.nvim_set_keymap

-- Positional splits
map('n', '<leader>we', '<c-w>v<c-w>l', {noremap = true})
map('n', '<leader>ws', '<c-w>s<c-w>j', {noremap = true})
map('n', '<leader>wq', '<c-w>v<c-w>h', {noremap = true})
map('n', '<leader>w2', '<c-w>s<c-w>k', {noremap = true})

-- Managing splits
map('n', '<leader>wo', ':on<cr>', {noremap = true})

-- Moving & resizing
map('n', '<leader>w=', '<c-w>=', {noremap = true})
map('n', '<leader>w0', '<c-w>|', {noremap = true})

-- Moving between splits
map('n', '<c-h>', '<c-w>h', {noremap = true})
map('n', '<c-j>', '<c-w>j', {noremap = true})
map('n', '<c-k>', '<c-w>k', {noremap = true})
map('n', '<c-l>', '<c-w>l', {noremap = true})
