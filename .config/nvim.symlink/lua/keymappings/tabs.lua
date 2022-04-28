local map = vim.api.nvim_set_keymap

map('n', '<leader>df', ':tab split<cr>', {noremap = true})
map('n', '<leader>dd', ':tabclose<cr>', {noremap = true})
map('n', '<leader>do', ':tabonly<cr>', {noremap = true})
