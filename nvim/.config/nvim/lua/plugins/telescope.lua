return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "debugloop/telescope-undo.nvim",
        keys = { { "<leader>U", "<cmd>Telescope undo<cr>", "Undo tree" } },
      },
      { "natecraddock/telescope-zf-native.nvim" },
      { "ThePrimeagen/harpoon" },
      {
        "ThePrimeagen/git-worktree.nvim",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("harpoon")
      telescope.load_extension("git_worktree")
      -- telescope.load_extension("import")
      -- telescope.load_extension("live_grep_args")
      -- telescope.load_extension("neoclip")
      -- telescope.load_extension("notify")
      -- telescope.load_extension("package_info")
      -- telescope.load_extension("tailiscope")
      telescope.load_extension("undo")
      telescope.load_extension("zf-native")
    end,
    opts = {
      defaults = {
        path_display = { "smart" },
        prompt_position = "top",
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        color_devicons = true,
        selection_strategy = "reset",
        scroll_strategy = "cycle",
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--hidden",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--trim", -- add this value
        },
        layout_config = {
          width = 0.95,
          height = 0.85,
          prompt_position = "top",
          horizontal = {
            preview_width = function(_, cols, _)
              if cols > 200 then
                return math.floor(cols * 0.4)
              else
                return math.floor(cols * 0.6)
              end
            end,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
        file_ignore_patters = {
          ".git/",
          "yarn.lock",
          "package-lock.json",
          "node_Modules",
          ".build",
          ".sst",
        },
        mappings = {
          i = {
            ["<C-n>"] = require("telescope.actions").cycle_history_next,
            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-c>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<Tab>"] = require("telescope.actions").toggle_selection
              + require("telescope.actions").move_selection_worse,
            ["<S-Tab>"] = require("telescope.actions").toggle_selection
              + require("telescope.actions").move_selection_better,
            ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            ["<C-l>"] = require("telescope.actions").complete_tag,
          },
          n = {
            ["<esc>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_default,
          },
        },
      },
      pickers = {
        git_files = {
          prompt_prefix = "󰊢 ",
          show_untracked = true,
        },
        find_files = {
          hidden = true,
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          previewer = false,
          theme = "dropdown",
        },
        lsp_references = {
          previewer = false,
        },
      },
      extensions = {
        ["zf-native"] = {
          file = { -- options for sorting file-like items
            enable = true, -- override default telescope file sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = true, -- enable zf filename match priority
          },
          generic = { -- options for sorting all other items
            enable = true, -- override default telescope generic item sorter
            highlight_results = true, -- highlight matching text in results
            match_filename = false, -- disable zf filename match priority
          },
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({
            -- even more opts
          }),
        },
        project = {
          base_dirs = {
            "~/code",
          },
          theme = "dropdown",
        },
      },
    },
    keys = {
      { "<C-t>", "<cmd>Telescope<cr>", desc = "Telescope" },
      { "<C-p>", "<cmd>Telescope git_files<CR>", desc = "git files" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[fb] Find existing buffers" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "[bb] Find existing buffers" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[ff] Find Files" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[fr] Find recently opened files" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "[gc] Git commits" },
      { "<leader>gf", "<cmd>Telescope git_files<CR>", desc = "[gf] Git files" },
      -- search
      { "<leader>s.", "<cmd>Telescope find_files search_dirs=~/.dotfiles<cr>", desc = "Auto Commands" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "[fr] Find recently opened files" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Word" },
      {
        "<leader>fc",
        function()
          require("telescope.builtin").colorscheme({ enable_preview = true })
        end,
        desc = "Colorscheme with preview",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
  },
}
