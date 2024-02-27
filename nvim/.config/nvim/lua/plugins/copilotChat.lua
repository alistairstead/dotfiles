--- Get all the changes in the git repository
---@param staged? boolean
---@return string
local function get_git_diff(staged)
  local cmd = staged and "git diff --staged" or "git diff"
  local handle = io.popen(cmd)
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvements for performance, clarity and readability.",
  Tests = "Please breifly explain how the selected code works, then generate unit tests for it with vitest.",
  Refactor = "Please refactor the following code to improve its performance, clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  -- Import the copilot plugin
  { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      show_help = "no",
      prompts = prompts,
      debug = false, -- Set to true to see the response from GitHub Copilot API. The log file will be in ~/.local/state/nvim/CopilotChat.nvim.log.
      disable_extra_info = "yes", -- Disable extra information (e.g.: system prompt, token count) in the response.
      hide_system_prompt = "yes", -- Show user prompts only and hide system prompts.
      proxy = "", -- Proxies requests via https or socks
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = function()
      local wk = require("which-key")
      wk.register({
        c = {
          c = {
            name = "+Copilot",
          },
        },
      }, {
        prefix = "<leader>",
        mode = { "n" },
        silent = true,
        noremap = true,
        nowait = false,
      })
      return {
        -- Show help actions with telescope
        {
          "<leader>cch",
          function()
            require("CopilotChat.code_actions").show_help_actions()
          end,
          desc = "Prompt actions",
        },
        {
          "<leader>ccp",
          ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
          mode = "x",
          desc = "Prompt actions",
        },
        -- Code-related commands
        { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
        { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
        { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
        { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
        { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
        -- Chat with Copilot in visual mode
        {
          "<leader>ccv",
          ":CopilotChatVisual",
          mode = "x",
          desc = "Open in vertical split",
        },
        {
          "<leader>ccx",
          ":CopilotChatInPlace<cr>",
          mode = "x",
          desc = "Run in-place code",
        },
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
          "<leader>ccm",
          function()
            local diff = get_git_diff()
            if diff ~= "" then
              vim.fn.setreg('"', diff)
              vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
            end
          end,
          desc = "Generate commit message for all changes",
        },
        {
          "<leader>ccM",
          function()
            local diff = get_git_diff(true)
            if diff ~= "" then
              vim.fn.setreg('"', diff)
              vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
            end
          end,
          desc = "Generate commit message for staged changes",
        },
        -- Quick chat with Copilot
        {
          "<leader>ccq",
          function()
            local input = vim.fn.input("Quick Chat: ")
            if input ~= "" then
              -- Copy all the lines to the unnamed register
              vim.cmd('normal! ggVG"*y')
              vim.cmd("CopilotChat " .. input)
            end
          end,
          desc = "Quick chat",
        },
        -- Debug
        { "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
        -- Fix the issue with the diagnostic
        { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
        -- Clear buffer and chat history
        { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
        -- Toggle Copilot Chat Vsplit
        { "<leader>ccv", "<cmd>CopilotChatVsplitToggle<cr>", desc = "Toggle Vsplit" },
      }
    end,
  },
}
