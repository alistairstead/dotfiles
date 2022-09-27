local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end


-- keymaps
local keymap = vim.keymap.set
local builtin = require('telescope.builtin')

keymap("n", "<C-t>", function()
  builtin.builtin()
end, { desc = "Telescope" })

keymap("n", "<C-p>", function()
  builtin.find_files()
end, { desc = "Find files" })

keymap("n", "<leader>ff", function()
  builtin.find_files()
end, { desc = "Find files" })

keymap("n", "<leader>fg", function()
  builtin.live_grep()
end, { desc = "Grep files" })

keymap("n", "<leader>b", function()
  builtin.buffers()
end, { desc = "Select buffers" })

keymap("n", "<leader>pp", function()
  telescope.extensions.project.project()
end, { desc = "Find Project" })

