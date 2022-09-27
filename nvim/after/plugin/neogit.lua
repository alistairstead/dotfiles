local ok, neogit = pcall(require, "neogit")
if not ok then
    return
end

neogit.setup({})

local keymap = vim.keymap.set

keymap("n", "<leader>gs", function()
  neogit.open()
end, { desc = "Neogit Open" })
