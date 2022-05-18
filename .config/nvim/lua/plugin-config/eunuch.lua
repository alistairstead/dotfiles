local map = vim.api.nvim_set_keymap

map('n', '<leader>mv', ':Move! <c-r>=fnamemodify(expand("%:p"), ":~:.")<cr>', {noremap = true})
map('n', '<leader>rn', ':Rename! <c-r>=expand("%:t")<cr>', {noremap = true})
map('n', '<leader>rm', ':Delete<cr>', {noremap = true})
map('n', '<leader>mkd', ':Mkdir! <c-r>=fnamemodify(expand("%:p:h"), ":~:.")."/"<cr>', {noremap = true})
