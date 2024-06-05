return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap", suite = true })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        "<cmd>lua require('neotest').run.run({ jestCommand = 'pnpm test:watch ' })<cr>",
        desc = "Run Watch",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({
            enter = true,
            auto_close = true,
            open_win = function()
              vim.cmd("vsplit")
            end,
          })
        end,
        desc = "Show Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
    },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(
        opts.adapters,
        require("neotest-go")({
          experimental = {
            test_table = true,
          },
          recursive_run = true,
        })
      )
      table.insert(opts.output, {
        open_on_run = false,
      })
      -- table.insert(opts.adapters, require("neotest-jest")({}))
    end,
  },
}
