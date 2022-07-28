require("telescope").setup{
  defaults = {
    file_ignore_patters = { "yarn.lock" }
  }
}
require('telescope').load_extension('fzf')

local map = vim.api.nvim_set_keymap

map('n', '<c-t>', ':Telescope find_files<cr>', {noremap = true})
map('n', '<c-f>', ':Telescope file_browser<cr>', {noremap = true})
map('n', '<c-g>', ':Telescope live_grep<cr>', {noremap = true})
map('n', '<c-b>', ':Telescope buffers<cr>', {noremap = true})
