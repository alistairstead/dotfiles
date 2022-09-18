local opt = vim.opt

opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.title = true
opt.termguicolors = true
opt.spell = false
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.breakindent = true -- maintain indent when wrapping indented lines
opt.list = true -- enable the below listchars
opt.listchars = { tab = '▸ ', trail = '·' }
opt.fillchars:append({ eob = ' ' }) -- remove the ~ from end of buffer
opt.mouse = 'a' -- enable mouse for all modes
opt.splitbelow = true
opt.splitright = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.clipboard = 'unnamedplus' -- Use Linux system clipboard
opt.confirm = true -- ask for confirmation instead of erroring
opt.undofile = true -- persistent undo
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.backup = false -- automatically save a backup file
opt.backupdir:remove('.') -- keep backups out of the current directory
opt.shortmess:append({ I = true }) -- disable the splash screen
opt.wildmode = 'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them
opt.signcolumn = 'yes:2'
opt.showmode = false
opt.updatetime = 4001 -- Set updatime to 1ms longer than the default to prevent polyglot from changing it
opt.redrawtime = 10000 -- Allow more time for loading syntax on large files

-- disable providers that are not being used
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
