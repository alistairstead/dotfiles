-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Shorten function name
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Better escape using jk in insert and terminal mode
map("i", "jk", "<ESC>", default_opts)
map("t", "jk", "<C-\\><C-n>", default_opts)

-- windows
-- vim.keymap.del("n", "<leader>w-")
-- vim.keymap.del("n", "<leader>w|")

map("n", "<leader>wh", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })

-- macro
-- map("n", "q", "<Nop>", { remap = true })
-- map("n", "<leader>r", "q", { desc = "Start recording macro", remap = true })
