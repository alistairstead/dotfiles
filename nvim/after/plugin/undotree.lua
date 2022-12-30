local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open undo tree' })
