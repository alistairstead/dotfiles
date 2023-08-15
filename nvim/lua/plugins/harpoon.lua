return {
  "ThePrimeagen/harpoon",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      -- config = function()
      --   require('telescope').load_extension('harpoon')
      -- end,
    },
  },
  -- lazy = true,
  opts = {
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    },
  },
  keys = {
    {
      "<C-a>",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon - Add file",
    },
    {
      "<C-e>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon - Toggle quick menu",
    },
    {
      "<C-w>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon - File 2",
    },
    {
      "<C-q>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon - File 1",
    },
  },
}
