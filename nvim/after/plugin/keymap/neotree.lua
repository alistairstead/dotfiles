local ok, neotree = pcall(require, 'neo-tree')
if not ok then
  return
end

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>e', '<cmd>Neotree toggle<CR>', {
  desc = 'Tree toggle',
})
