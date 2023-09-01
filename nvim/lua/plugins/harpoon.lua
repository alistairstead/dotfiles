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
      "<leader>ha",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon - Add file",
    },
    {
      "<leader>he",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon - Toggle quick menu",
    },
    {
      "<leader>1",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon - File 1",
    },
    {
      "<leader>2",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon - File 2",
    },
    {
      "<leader>3",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harpoon - File 3",
    },
    {
      "<leader>4",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harpoon - File 4",
    },
  },
}
