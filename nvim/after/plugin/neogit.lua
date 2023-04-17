local ok, neogit = pcall(require, 'neogit')
if not ok then
  return
end

neogit.setup({
  console_timeout = 20000,
  disable_commit_confirmation = true,
  auto_show_console = false,
  disable_insert_on_commit = false,
})

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap

nnoremap('<leader>gs', function()
  neogit.open()
end, { desc = 'Neogit Open' })
