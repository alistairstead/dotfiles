return {
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
      })
    end,
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
    keys = function()
      local chatgpt = require("chatgpt")
      local wk = require("which-key")

      wk.register({
        a = {
          function()
            chatgpt.edit_with_instructions()
          end,
          "Edit with instructions",
        },
      }, {
        prefix = "<leader>",
        mode = "v",
      })
      return {
        {
          "<leader>ac",
          "<cmd>ChatGPT<CR>",
          desc = "ChatGPT",
        },
        {
          "<leader>ae",
          "<cmd>ChatGPTEditWithInstruction<CR>",
          desc = "Edit with istruction",
          mode = { "n", "v" },
        },
        {
          "<leader>ag",
          "<cmd>ChatGPTRun grammar_correction<CR>",
          desc = "Grammar correction",
          mode = { "n", "v" },
        },
        {
          "<leader>at",
          "<cmd>ChatGPTRun translate<CR>",
          desc = "Translate",
          mode = { "n", "v" },
        },
        {
          "<leader>ak",
          "<cmd>ChatGPTRun keywords<CR>",
          desc = "Keywords",
          mode = { "n", "v" },
        },
        {
          "<leader>ad",
          "<cmd>ChatGPTRun docstring<CR>",
          desc = "Doctstring",
          mode = { "n", "v" },
        },
        {
          "<leader>at",
          "<cmd>ChatGPTRun add_tests<CR>",
          desc = "Add tests",
          mode = { "n", "v" },
        },
        {
          "<leader>ao",
          "<cmd>ChatGPTRun optimize_code<CR>",
          desc = "Optimize",
          mode = { "n", "v" },
        },
        {
          "<leader>as",
          "<cmd>ChatGPTRun summarize<CR>",
          desc = "Summarize",
          mode = { "n", "v" },
        },
        {
          "<leader>ab",
          "<cmd>ChatGPTRun fix_bugs<CR>",
          desc = "Fix bugs",
          mode = { "n", "v" },
        },
        {
          "<leader>ax",
          "<cmd>ChatGPTRun explain_code<CR>",
          desc = "Explain",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
