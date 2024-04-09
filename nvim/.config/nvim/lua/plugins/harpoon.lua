return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    {
      "nvim-telescope/telescope.nvim",
      keys = function()
        local harpoon = require("harpoon")
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, item.value)
          end

          require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = conf.file_previewer({}),
              sorter = conf.generic_sorter({}),
            })
            :find()
        end
        return {
          {
            "<C-e>",
            function()
              toggle_telescope(harpoon:list())
            end,
            desc = "Harpoon - list",
          },
        }
      end,
    },
  },
  opts = {
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    },
  },
  keys = function()
    local harpoon = require("harpoon")
    local wk = require("which-key")
    wk.register({
      h = {
        name = "+Harpoon",
      },
    }, {
      prefix = "<leader>",
      mode = { "n" },
    })
    return {
      {
        "<leader>fm",
        "<cmd>Telescope harpoon marks<cr>",
        desc = "Telescope Harpoon Marks",
      },
      {
        "<leader>ha",
        function()
          harpoon:list():append()
        end,
        desc = "Add file",
      },
      {
        "<leader>hh",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Toggle quick menu",
      },
      {
        "<leader>h1",
        function()
          harpoon:list():select(1)
        end,
        desc = "Mark 1",
      },
      {
        "<leader>h2",
        function()
          harpoon:list():select(2)
        end,
        desc = "Mark 2",
      },
      {
        "<leader>h3",
        function()
          harpoon:list():select(3)
        end,
        desc = "Mark 3",
      },
      {
        "<leader>h4",
        function()
          harpoon:list():select(4)
        end,
        desc = "Mark 4",
      },
      {
        "<leader>h5",
        function()
          harpoon:list():select(5)
        end,
        desc = "Mark 5",
      },
    }
  end,
}
