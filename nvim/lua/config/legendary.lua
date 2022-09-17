local M = {}

local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }

function M.setup()
  local status_ok, legendary = pcall(require, "legendary")
  if not status_ok then
    return
  end

  legendary.setup { include_builtin = true, auto_register_which_key = true }
  keymap("n", "<C-p>", "<cmd>lua require('legendary').find()<CR>", default_opts)
end

return M
