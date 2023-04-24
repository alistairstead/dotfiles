return {
  'TimUntersberger/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    console_timeout = 20000,
    disable_commit_confirmation = true,
    auto_show_console = false,
    disable_insert_on_commit = false,
  },
  keys = {
    {
      '<leader>gs',
      function()
        require('neogit').open()
      end,
      desc = 'Neogit - Git Status',
    },
  },
}
