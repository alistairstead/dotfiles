local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate vitest unit tests for it using describe() and it().",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  FixError = "Please explain the error in the following text and provide a solution.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    version = "v2.*",
    -- branch = "canary",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    opts = {
      prompts = prompts,
      window = {
        title = " Chat",
      },
    },
    keys = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>cc", group = "Copilot", nowait = false, remap = false },
      })
      return {
        -- Show help actions with telescope
        {
          "<leader>cch",
          function()
            require("CopilotChat.code_actions").show_help_actions({
              selection = require("CopilotChat.select").line,
            })
          end,
          desc = "Help actions",
        },
        -- Show prompts actions with telescope
        {
          "<leader>ccp",
          function()
            local actions = require("CopilotChat.actions")
            require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
          end,
          desc = "Prompt actions",
        },
        -- Code related commands
        { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
        { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
        { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
        { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
        { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
        -- Custom input for CopilotChat
        {
          "<leader>cci",
          function()
            local input = vim.fn.input("Ask Copilot: ")
            if input ~= "" then
              vim.cmd("CopilotChat " .. input)
            end
          end,
          desc = "Ask input",
        },
        -- Generate commit message based on the git diff
        {
          "<leader>ccM",
          "<cmd>CopilotChatCommit<cr>",
          desc = "Generate commit message for all changes",
        },
        {
          "<leader>ccm",
          "<cmd>CopilotChatCommitStaged<cr>",
          desc = "Generate commit message for staged changes",
        },
        -- Quick chat with Copilot
        {
          "<leader>ccq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              vim.cmd("CopilotChatBuffer " .. input)
            end
          end,
          desc = "Quick chat",
        },
        -- Create documentation
        { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Draft documentation" },
        -- Fix the issue with diagnostic
        { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
        -- Clear buffer and chat history
        { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
        -- Toggle Copilot Chat Vsplit
        { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Vsplit" },
      }
    end,
  },
}
