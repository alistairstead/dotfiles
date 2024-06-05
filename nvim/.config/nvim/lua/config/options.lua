-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt

opt.laststatus = 3 -- show a single global status line
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.swapfile = false
opt.mouse = ""
opt.spelllang = "en_gb"
opt.spellfile = "~/.config/nvim/spell/en.utf-8.add"

opt.listchars = {
  space = " ",
  eol = " ", -- "↲",
  nbsp = "␣",
  trail = "·",
  precedes = "←",
  extends = "→",
  tab = "¬ ",
  conceal = "※",
}

vim.o.cmdheight = 0
vim.o.showcmdloc = "statusline"
