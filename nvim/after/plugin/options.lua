-- :help options

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
opt.undofile = true -- enable persistent undo
opt.undodir = os.getenv('HOME') .. '/.vim/undodir' -- where to store undo files
opt.backup = false
opt.backupdir:remove('.') -- keep backups out of the current directory
opt.shortmess:append({ I = true }) -- disable the splash screen
opt.wildmode = 'longest:full,full' -- complete the longest common match, and allow tabbing the results to fully complete them
opt.signcolumn = 'yes:2'
opt.showmode = false
opt.updatetime = 4001 -- Set updatime to 1ms longer than the default to prevent polyglot from changing it
opt.redrawtime = 10000 -- Allow more time for loading syntax on large files
opt.laststatus = 3 -- show a single global status line
opt.cmdheight = 1
opt.completeopt = { 'noinsert', 'menuone', 'noselect' }
opt.pumheight = 10
opt.numberwidth = 4
opt.termguicolors = true

local g = vim.g
-- disable providers that are not being used
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

-- Disable some builtin vim plugins
-- g.do_filetype_lua = 1 -- use filetype.lua
-- g.did_load_filetypes = 0 -- don't use filetype.vim
-- g.highlighturl_enabled = true -- highlight URLs by default
-- g.mapleader = ' ' -- set leader key
-- g.zipPlugin = false -- disable zip
-- g.load_black = false -- disable black
-- g.loaded_2html_plugin = true -- disable 2html
-- g.loaded_getscript = true -- disable getscript
-- g.loaded_getscriptPlugin = true -- disable getscript
-- g.loaded_gzip = true -- disable gzip
-- g.loaded_logipat = true -- disable logipat
-- g.loaded_matchit = true -- disable matchit
-- g.loaded_netrwFileHandlers = true -- disable netrw
-- g.loaded_netrwPlugin = true -- disable netrw
-- g.loaded_netrwSettngs = true -- disable netrw
-- g.loaded_remote_plugins = true -- disable remote plugins
-- g.loaded_tar = true -- disable tar
-- g.loaded_tarPlugin = true -- disable tar
-- g.loaded_zip = true -- disable zip
-- g.loaded_zipPlugin = true -- disable zip
-- g.loaded_vimball = true -- disable vimball
-- g.loaded_vimballPlugin = true -- disable vimball
