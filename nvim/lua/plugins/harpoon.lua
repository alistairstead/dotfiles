return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('harpoon').setup {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    }
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')
    local nnoremap = require('alistairstead.keymap').nnoremap

    local silent = { silent = true }

    nnoremap('<leader>a', function()
      mark.add_file()
    end, silent)

    nnoremap('<C-e>', function()
      ui.toggle_quick_menu()
    end, silent)

    nnoremap('<C-w>', function()
      ui.nav_file(2)
    end, silent)

    nnoremap('<C-q>', function()
      ui.nav_file(1)
    end, silent)

    require("telescope").load_extension "harpoon"
  end,
}
