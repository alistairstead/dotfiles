local ok, neogit = pcall(require, 'neogit')
if not ok then
  return
end

neogit.setup({})

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>gs', function()
  neogit.open()
end, { desc = 'Neogit Open' })
