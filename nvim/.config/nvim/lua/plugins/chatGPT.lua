return {
  {
    "jackMort/ChatGPT.nvim",
    enabled = false,
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
        openai_params = {
          model = "gpt-3.5-turbo",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 1000,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end,
    -- event = "VeryLazy",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTCompleteCode",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    -- init = function()
    --   local wk = require("which-key")
    --   wk.register({
    --     m = {
    --       name = "+ChatGPT",
    --       c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    --       e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    --       g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    --       t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    --       k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    --       d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    --       a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    --       o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    --       s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    --       f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    --       x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    --       r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    --       l = {
    --         "<cmd>ChatGPTRun code_readability_analysis<CR>",
    --         "Code Readability Analysis",
    --         mode = { "n", "v" },
    --       },
    --     },
    --   }, { prefix = "<leader>" })
    -- end,
    keys = function()
      local chatgpt = require("chatgpt")
      local wk = require("which-key")

      wk.register({
        m = {
          name = "+ChatGPT",
        },
      }, {
        prefix = "<leader>",
        mode = { "v", "n" },
      })
      return {
        {
          "<leader>mc",
          "<cmd>ChatGPT<CR>",
          desc = "ChatGPT",
        },
        {
          "<leader>me",
          "<cmd>ChatGPTEditWithInstruction<CR>",
          desc = "Edit with istruction",
          mode = { "n", "v" },
        },
        {
          "<leader>mg",
          "<cmd>ChatGPTRun grammar_correction<CR>",
          desc = "Grammar correction",
          mode = { "n", "v" },
        },
        {
          "<leader>mt",
          "<cmd>ChatGPTRun translate<CR>",
          desc = "Translate",
          mode = { "n", "v" },
        },
        {
          "<leader>mk",
          "<cmd>ChatGPTRun keywords<CR>",
          desc = "Keywords",
          mode = { "n", "v" },
        },
        {
          "<leader>md",
          "<cmd>ChatGPTRun docstring<CR>",
          desc = "Doctstring",
          mode = { "n", "v" },
        },
        {
          "<leader>mt",
          "<cmd>ChatGPTRun add_tests<CR>",
          desc = "Add tests",
          mode = { "n", "v" },
        },
        {
          "<leader>mo",
          "<cmd>ChatGPTRun optimize_code<CR>",
          desc = "Optimize",
          mode = { "n", "v" },
        },
        {
          "<leader>ms",
          "<cmd>ChatGPTRun summarize<CR>",
          desc = "Summarize",
          mode = { "n", "v" },
        },
        {
          "<leader>mf",
          "<cmd>ChatGPTRun fix_bugs<CR>",
          desc = "Fix bugs",
          mode = { "n", "v" },
        },
        {
          "<leader>mx",
          "<cmd>ChatGPTRun explain_code<CR>",
          desc = "Explain",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
