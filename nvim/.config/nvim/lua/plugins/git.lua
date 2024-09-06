return {
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      disable_hint = false,
      disable_commit_confirmation = "auto",
      console_timeout = 2000,
      auto_show_console = false,
      disable_insert_on_commit = false,
      integrations = {
        telescope = true,
        diffview = true,
      },
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      signs = {
        -- { CLOSED, OPENED }
        hunk = { "", "" },
        item = { "", "" },
        section = { "", "" },
      },
    },
    keys = {
      { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Git branches" },
      { "<leader>gc", "<cmd>lua require('neogit').open({'commit'})<CR>", desc = "Git commit" },
      {
        "<leader>gg",
        function()
          require("neogit").open({ cwd = vim.fn.expand("%:p:h") })
        end,
        desc = "Neogit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    opts = function()
      local actions = require("diffview.actions")
      return {
        keymaps = {
          file_panel = {
            ["q"] = "<cmd>DiffviewClose<cr>",
          },
        },
      }
    end,
    keys = { { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" } },
  },
  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        config = function()
          require("telescope").load_extension("git_worktree")
        end,
      },
    },
    config = function(_, opts)
      require("git-worktree").setup(opts)
      local Worktree = require("git-worktree")
      local function file_exists(filename)
        local file = io.open(filename, "r")
        if file then
          -- Obviously close the file if it did successfully open.
          file:close()
          return true
        end
        return false
      end

      -- op = Operations.Switch, Operations.Create, Operations.Delete
      -- metadata = table of useful values (structure dependent on op)
      --      Switch
      --          path = path you switched to
      --          prev_path = previous worktree path
      --      Create
      --          path = path where worktree created
      --          branch = branch name
      --          upstream = upstream remote name
      --      Delete
      --          path = path where worktree deleted

      Worktree.on_tree_change(function(op, metadata)
        if op == Worktree.Operations.Switch then
          print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
          if file_exists(".envrc") then
            local handle = io.popen([["/opt/homebrew/bin/direnv allow ."]])
            if handle == nil then
              print("direnv allow . failed")
              return
            end
            local result = handle:read("*a")
            local ok, _, _ = handle:close()
            if ok then
              print("direnv allow .")
              print(result)
            else
              print("direnv allow . failed")
            end
          end
          if file_exists("pnpm-lock.yaml") then
            local handle = io.popen([["/opt/homebrew/bin/pnpm i"]])
            if handle == nil then
              print("pnpm install failed")
              return
            end
            local result = handle:read("*a")
            local ok, _, _ = handle:close()
            if ok then
              print("phpm install")
              print(result)
            else
              print("pnpm install failed")
            end
          end
        end
      end)
    end,
    keys = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>gw", group = "Worktree", nowait = false, remap = false },
      })
      return {
        {
          "<leader>gww",
          function()
            require("telescope").extensions.git_worktree.git_worktrees()
          end,
          desc = "Worktree switch and delete <c-d>",
        },
        {
          "<leader>gwc",
          function()
            require("telescope").extensions.git_worktree.create_git_worktree()
          end,
          desc = "Worktree create",
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "┊" },
        change = { text = "┊" },
        delete = { text = "┊" },
        topdelete = { text = "┊" },
        changedelete = { text = "┊" },
        untracked = { text = "┊" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map({ "n", "v" }, "<leader>gx", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gh", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gX", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gB", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
    keys = {
      -- git hunk navigation - previous / next
      { "gh", ":Gitsigns next_hunk<CR>", desc = "Goto next git hunk" },
      { "gH", ":Gitsigns prev_hunk<CR>", desc = "Goto previous git hunk" },
      { "]g", ":Gitsigns next_hunk<CR>", desc = "Goto next git hunk" },
      { "[g", ":Gitsigns prev_hunk<CR>", desc = "Goto previous git hunk" },
    },
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
    keys = {
      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n")
        end,
        desc = "Yank GitHub URL",
      },
    },
  },
}
