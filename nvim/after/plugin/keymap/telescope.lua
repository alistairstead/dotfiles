local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local Remap = require('alistairstead.keymap')
local nnoremap = Remap.nnoremap
local builtin = require('telescope.builtin')

nnoremap('<C-t>', function()
  builtin.builtin()
end, { desc = 'Telescope' })

nnoremap('<leader>ps', function()
  builtin.grep_string()
end, { desc = 'Grep files' })

nnoremap('<C-p>', function()
  builtin.git_files()
end, { desc = 'Git files' })

nnoremap('<Leader>ff', function()
  builtin.find_files()
end, { desc = 'Find files' })

nnoremap('<leader>pw', function()
  builtin.grep_string({ search = vim.fn.expand('<cword>') })
end)

nnoremap('<leader>b', function()
  builtin.buffers()
end, { desc = 'Select buffers' })

nnoremap('<leader>pp', function()
  telescope.extensions.project.project()
end, { desc = 'Select buffers' })

nnoremap('<leader>vh', function()
  builtin.help_tags()
end)

nnoremap('<leader>gw', function()
  telescope.extensions.git_worktree.git_worktrees()
end)

nnoremap('<leader>gm', function()
  telescope.extensions.git_worktree.create_git_worktree()
end)
