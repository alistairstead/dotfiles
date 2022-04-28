local map = vim.api.nvim_set_keymap

map('n', '<leader>gs', ':Git<cr>', {noremap = true})
map('n', '<leader>ga', ':Gwrite<cr>', {noremap = true})
map('n', '<leader>gc', ':Git commit --verbose<cr>', {noremap = true})
