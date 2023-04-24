return {
  'mbbill/undotree',
  lazy = true,
  keys = {
    { "<leader>u", vim.cmd.UndotreeToggle, desc = "Open undo tree" },
  },
}
