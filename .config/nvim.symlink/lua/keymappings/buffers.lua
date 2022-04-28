local map = vim.api.nvim_set_keymap

map('n', '<leader>bc', ':bd<cr>', {noremap = true})
map('n', '<leader>bo', ':%bd<cr><C-O>:bd#<cr>', {noremap = true})
map('n', '<leader>bd', ':bufdo bd<cr>', {noremap = true})
