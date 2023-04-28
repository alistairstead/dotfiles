return {
  'akinsho/toggleterm.nvim',
  opts = {
    insert_mappings = false,
    env = {
      MANPAGER = 'less -X',
    },
    terminal_mappings = false,
    start_in_insert = true,
    close_on_exit = true,
    siize = 20,
    open_mapping = [[<C-\>]],
  },
  keys = {
    { '<C-\\>', '<cmd>ToggleTerm<cr>', desc = 'ToggleTerm' },
  },
}
