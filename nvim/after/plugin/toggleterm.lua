local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  return
end

toggleterm.setup({
  insert_mappings = false,
  env = {
    MANPAGER = 'less -X',
  },
  terminal_mappings = false,
  start_in_insert = true,
  close_on_exit = true,
  siize = 20,
  open_mapping = [[<C-\>]],
})

-- Remove WinEnter to allow moving a toggleterm to new tab
vim.cmd.autocmd({ 'ToggleTermCommands', 'WinEnter', bang = true })
