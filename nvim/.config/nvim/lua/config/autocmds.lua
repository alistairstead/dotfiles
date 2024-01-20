-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local create_autocmd = vim.api.nvim_create_autocmd

create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function(match)
    vim.o.cmdheight = match.event == "RecordingEnter" and 1 or 0
  end,
})

create_autocmd("BufWritePost", {
  pattern = { ".yabairc" },
  command = "!yabai --restart-service",
})

create_autocmd("BufWritePost", {
  pattern = { "*tmux.conf" },
  command = "execute 'silent !tmux source <afile> --silent'",
})
