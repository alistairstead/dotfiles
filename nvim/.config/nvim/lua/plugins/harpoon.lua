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
    return {
      {
        "<leader>ha",
        function()
          harpoon:list():append()
        end,
        desc = "Harpoon - Add file",
      },
      {
        "<leader>he",
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon - Toggle quick menu",
      },
      {
        "<leader>1",
        function()
          harpoon:list():select(1)
        end,
        desc = "Harpoon - File 1",
      },
      {
        "<leader>2",
        function()
          harpoon:list():select(2)
        end,
        desc = "Harpoon - File 2",
      },
      {
        "<leader>3",
        function()
          harpoon:list():select(3)
        end,
        desc = "Harpoon - File 3",
      },
      {
        "<leader>4",
        function()
          harpoon:list():select(4)
        end,
        desc = "Harpoon - File 4",
      },
    }
  end,
}
