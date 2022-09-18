-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_git_hl = 1
local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
    return
end

local nvim_tree_config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not nvim_tree_config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

require('nvim-tree').setup({
  filters = {
    dotfiles = false,
    custom = { "node_modules" },
  },
  git = {
    ignore = false,
  },
  view = {
    side = 'right',
    mappings = {
      custom_only = false,
      list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
          { key = "h", cb = tree_cb("close_node") },
          { key = "v", cb = tree_cb("vsplit") },
      },
    },
  },
  renderer = {
    highlight_opened_files = '1',
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
  },
})

vim.cmd([[
  highlight NvimTreeIndentMarker guifg=#30323E
  augroup NvimTreeHighlights
    autocmd ColorScheme * highlight NvimTreeIndentMarker guifg=#30323E
  augroup end
]])

vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
