-- Relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Indentation visuals
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Configure screen scroll jumps
vim.opt.scrolloff = 4
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

-- Line wrapping
vim.opt.wrap = false
vim.wo.wrap = true
vim.wo.linebreak = true

-- Configure incremental search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Case-insensitive search unless mixed case query used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Global search-n-replace by default
vim.opt.gdefault = true

-- Disable swaps and backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Enable cross-session undo
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- Set really short screen refresh
vim.opt.updatetime = 50

vim.opt.clipboard = 'unnamedplus' -- Use Linux system clipboard
vim.opt.laststatus = 3 -- show a single global status line
vim.opt.showtabline = 0

vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0