local ok, neotest = pcall(require, "neotest")
if not ok then
    return
end

local keymap = vim.keymap.set
keymap("n", "<leader>tn", function()
  neotest.run.run()
end, { desc = "Run nearest test" })
keymap("n", "<leader>tf", function()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run tests in file" })
keymap("n", "<leader>tl", function()
  neotest.run.run_last()
end, { desc = "Rerun last test" })
keymap("n", "<leader>to", function()
  neotest.output.open()
end, { desc = "Open test output" })
keymap("n", "<leader>ts", function()
  neotest.summary.toggle()
end, { desc = "Test summary" })
