require'nvim-tree'.setup {
  filters = {
    custom = {".git", "node_modules", ".build", ".vscode"}
  },
  git = {
    ignore = true
  },
  view = {
    side = "right"
  }
}

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('n', '<C-k>', ':NvimTreeToggle<CR>', default_opts)
map('n', '<C-j>', ':NvimTreeFindFile<CR>', default_opts)
