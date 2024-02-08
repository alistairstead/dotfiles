return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
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
          require("neotest").run.run_last({ strategy = "dap" })
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
    -- opts = {
    --   output = {
    --     open_on_run = false,
    --   },
    --   adapters = {
    --     ["neotest-vitest"] = {
    --       -- vitestConfigFile = function()
    --       --   local file = vim.fn.expand("%:p")
    --       --   if string.find(file, "/packages/") then
    --       --     return string.match(file, "(.-/[^/]+/)src") .. "vitest.config.ts"
    --       --   end
    --       --   if string.find(file, "/apps/") then
    --       --     return string.match(file, "(.-/[^/]+/)src") .. "vitest.config.ts"
    --       --   end
    --       --
    --       --   return vim.fn.getcwd() .. "/vitest.config.ts"
    --       -- end,
    --       -- env = { CI = true },
    --       -- cwd = function()
    --       --   return vim.fn.getcwd()
    --       -- end,
    --     },
    --     -- ["neotest-jest"] = {
    --     --   jestCommand = "pnpm test --",
    --     --   jestConfigFile = function()
    --     --     local file = vim.fn.expand("%:p")
    --     --     if string.find(file, "/packages/") then
    --     --       return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
    --     --     end
    --     --
    --     --     return vim.fn.getcwd() .. "/jest.config.ts"
    --     --   end,
    --     --   env = { CI = true },
    --     --   cwd = function()
    --     --     return vim.fn.getcwd()
    --     --   end,
    --     -- },
    --   },
    -- },
    opts = function(_, opts)
      table.insert(opts.adapters, require("neotest-vitest"))
      table.insert(opts.output, {
        open_on_run = false,
      })
      table.insert(opts.adapters, require("neotest-jest")({}))
    end,
  },
}
