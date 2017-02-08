call plug#begin('~/.config/nvim/plugged')

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
" Base functionality
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
" COMPLETION
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'wellle/tmux-complete.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-git'
Plug 'tpope/vim-abolish'
Plug 'rizzatti/dash.vim'
Plug 'kana/vim-smartinput'
Plug 'Lokaltog/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-scripts/BufOnly.vim'
Plug 'scrooloose/syntastic'
" UI
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'airblade/vim-gitgutter'
" TESTING
Plug 'neomake/neomake'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'
" SEARCH
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" CSS
Plug 'ap/vim-css-color', { 'for': 'css' }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
" ELIXIR
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
" ELk
Plug 'elmcast/elm-vim', { 'for': 'elm' }
" HTML
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'erb', 'twig' ] }
" JAVASCRIPT
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
" LESS
Plug 'groenewege/vim-less', { 'for': 'less' }

call plug#end()

se cursorline

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set tabstop=2 softtabstop=2 shiftwidth=2 noexpandtab
" Set split separator to Unicode box drawing character
set fillchars=vert:│

let mapleader=" "
set number
set noswapfile

"  THEME OPTIONS
" Molokai
let g:rehash256=1
syntax on
set background=dark
colorscheme molokai

"  FOLDING
se foldmethod=syntax
se foldlevel=4

"  SEARCH
se showmatch
se ignorecase
se smartcase
se gdefault
se tags+=vendor.tags

"  SCROLLING
se scrolljump=3
se scrolloff=3

"  AUTOCOMPLETION
se wildcharm=<tab>
se wildmode=full
se completeopt+=noinsert
inoremap <c-l> <c-x><c-l>
let g:deoplete#enable_at_startup = 1
let g:alchemist_tag_stack_map = '<C-Q>'

"  WRAPPING
se wrap
se linebreak
se textwidth=100
se colorcolumn=100
"se formatprg=par
"se formatoptions+=tca

"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > CUSTOM MAPPINGS
"|
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

" nvim integration with system clipboard
" yank to clipboard
if has('clipboard')
	"set clipboard=unnamed
  set clipboard+=unnamedplus
endif
"
" General overridings
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap Y y$

" Dash
nnoremap <leader>d :Dash<cr>

" Highlighting mappings
nnoremap <leader>ll :set list!<cr>
nnoremap <silent> <leader><space> :nohlsearch<cr>

" Lines movement
nnoremap <s-up>   [e
nnoremap <s-down> ]e
vnoremap <s-up>   [egv
vnoremap <s-down> ]egv

" FS Navigation
nnoremap <leader>ep :e <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>es :vsp <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>se :Vex<cr><c-w>=
nnoremap <leader>mk :!mkdir <c-r>=expand("%:p:h")."/"<cr>
nnoremap <leader>rm :!rm -rf <c-r>=expand("%:p:h")."/"<cr>
cnoremap w!!        w !sudo tee % >/dev/null

" Note that remapping C-s requires flow control to be disabled
" (e.g. in .bashrc or .zshrc)
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>

" Tabs management
nnoremap <leader>df :tab split<cr>
nnoremap <leader>dd :tabclose<cr>
nnoremap <leader>do :tabonly<cr>

" Windows management
nnoremap <leader>we <c-w>v<c-w>l
nnoremap <leader>ws <c-w>s<c-w>j
nnoremap <leader>wq <c-w>v<c-w>h
nnoremap <leader>w2 <c-w>s<c-w>k
nnoremap <leader>wo :on<cr>
nnoremap <leader>w= <c-w>=
nnoremap <leader>w0 <c-w>\|
nnoremap <leader>w- <c-w>_
nnoremap <leader>wk <c-w>K
nnoremap <leader>wh <c-w>H
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-x> <c-w>x
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
tnoremap <c-x> <c-\><c-n><c-w>x

" Movement tuning
nnoremap j     gj
nnoremap k     gk
nnoremap <tab> %
vnoremap <tab> %
vnoremap <     <gv
vnoremap >     >gv

" Movement combinations tuning
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
vnoremap <s-h>   <nop>
vnoremap <s-j>   <nop>
vnoremap <s-k>   <nop>
vnoremap <s-l>   <nop>

" Search tuning
" nnoremap / /\v
" vnoremap / /\v
" nnoremap * *N
nnoremap <CR> :noh<CR><CR>

" Buffer management
nnoremap <leader>bo :BufOnly<cr>
nnoremap <leader>bc :bd<cr>

map <Leader>vi :tabe ~/.vimrc<CR>
map <Leader>p :set paste<CR><esc>"*]p:set nopaste<cr>
map <Leader>mdg :!mix deps.get<cr>

"
" Airline
let g:airline_theme='molokai'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Fugitive
nnoremap <leader>gs  :Gstatus<cr>
nnoremap <leader>ga  :Gwrite<cr>
nnoremap <leader>gh  :Gbrowse!<cr>
nnoremap <leader>gc  :Gcommit --verbose<cr>
nnoremap <leader>grm :Gremove<cr>
nnoremap <leader>gmv :Gmove<cr>
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"  FZF
nnoremap <c-t> :FZF<cr>

" Ack
nnoremap <expr><leader>a ":Ack! "

" Tabular
nnoremap <leader><tab><tab> :Tab /
nnoremap <leader><tab>= :Tab /=<cr>
nnoremap <leader><tab>: :Tab /:\zs<cr>
nnoremap <leader><tab>> :Tab /=><cr>
vnoremap <leader><tab> :Tab /
vnoremap <leader><tab>= :Tab /=<cr>
vnoremap <leader><tab>: :Tab /:\zs<cr>
vnoremap <leader><tab>> :Tab /=><cr>

" Nerdtree
map <C-\> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1


" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#syntastic#enabled = 1

let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_php_checkers = ['php', 'phpmd']


" vim-tmux-navgator
let g:tmux_navigator_no_mappings = 1
" https://robots.thoughtbot.com/seamlessly-navigate-vim-and-tmux-splits
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
" Disable in favor of NERDTreeToggle
"nnoremap <silent> <c-\> :TmuxNavigatePrevious<cr>
" https://github.com/christoomey/vim-tmux-navigator#it-doesnt-work-in-neovim-specifically-c-h
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

"  EASYMOTION
let g:EasyMotion_leader_key='t'

"  NEOMAKE
function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'W'
        let a:entry.type = 'W'
    else
        let a:entry.type = 'I'
    endif
endfunction
let g:neomake_elixir_credo_maker = {
    \ 'exe': 'mix',
    \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
    \ 'errorformat': '[%t] %. %f:%l:%c %m',
    \ 'postprocess': function('NeomakeCredoErrorType')
    \ }

let g:neomake_elixir_enabled_makers = ['mix', 'credo']

"  VIMUX
nnoremap <leader>vr :VimuxPromptCommand<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vc :VimuxCloseRunner<cr>

"  TESTS
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "make"

" POLYGLOT
let g:polyglot_disabled = ['elm']

" Elm
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0

" php
let g:php_folding=1
let php_noShortTags = 1

nnoremap <leader>u :call PhpInsertUse()<cr>
nnoremap <leader>e :call PhpExpandClass()<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" Elixir
"run tests right from vim - super helpful
map <leader>m :!mix test<CR>

" Markdown
autocmd BufNewFile,BufRead *.md set spell | set lbr | set nonu
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']

" .vimrc
autocmd BufWritePost .vimrc source %

" BEHAT
" mandatory if you want the '*.feature' files to be set with behat filetype
let g:feature_filetype='behat'

" The plugin tries successively several behat executables to find the good one
" (php behat.phar, bin/behat, etc). You can define a custom list that will
" be prepended to the default path with g:behat_executables.
" let behat_executables = ['behat.sh']

" if you use neocomplcache add this to enable behat completion
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.behat = '\(When\|Then\|Given\|And\)\s.*$'

" disable omni completion steps cache
" normally you don't want to do this because it's slow (and will prevent neocomplcache from working)
" let g:behat_disable_omnicompl_cache = 1

"
"+>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
"|
"|  > CUSTOM FUNCTIONS
"|
"|
""""""""""""""""""""""""""""""""""""""""

":command Thtml :%!tidy -q -i --show-errors 0
":command Txml  :%!tidy -q -i --show-errors 0 -xml

" Merge a tab into a split in the previous window
function! MergeTabs()
	if tabpagenr() == 1
		return
	endif
	let bufferName = bufname("%")
	if tabpagenr("$") == tabpagenr()
		close!
	else
		close!
		tabprev
	endif
	split
	execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>

" Squash all commits into the first during rebase
function! SquashAll()
	normal ggj}klllcf:w
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
	let old_name = expand('%')
	let new_name = input('New file name: ', expand('%'), 'file')
	if new_name != '' && new_name != old_name
		exec ':saveas ' . new_name
		exec ':silent !rm ' . old_name
		redraw!
	endif
endfunction
map <Leader>n :call RenameFile()<cr>

"
""""""""""""""""""""""""""""""""""""""""
"
"  CREATE DIRECTORY FOR CURRENT BUFFER
"
function! <sid>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction

"  AUTOCMD
filetype on
filetype plugin on
filetype indent on

augroup vimrc_autocmd
    if ! has('gui_running')
        set ttimeoutlen=10
        au InsertEnter * set timeoutlen=500
        au InsertLeave * set timeoutlen=1000
    endif

    if has('autocmd')
        autocmd!

        " General
        au FocusLost silent! :wa
        au FileType helpfile setlocal nonumber

        " File types
        au BufRead,BufNewFile *.php         setlocal filetype=php iskeyword-=$
        au BufRead,BufNewFile *.php         inoremap <buffer> § $
        au BufRead,BufNewFile *.php         inoremap <buffer> ± ->
        au BufRead,BufNewFile *.php         inoremap <buffer> §§ $this->
        au BufRead,BufNewFile *.twig        setlocal filetype=jinja
        au BufRead,BufNewFile *.html.twig   setlocal filetype=htmljinja
        au BufRead,BufNewFile *.js.twig     setlocal filetype=javascript
        au BufRead,BufNewFile *.ejs         setlocal filetype=html
        au BufRead,BufNewFile *.json        setlocal filetype=javascript
        au BufRead,BufNewFile *.pp          setlocal filetype=ruby
        au BufRead,BufNewFile *.eex         setlocal filetype=elixir
        au BufRead,BufNewFile *.exs         setlocal filetype=elixir

        " Autocalls
        au BufWrite * :call <sid>MkdirsIfNotExists(expand('<afile>:h'))
				au BufWritePost,BufEnter * Neomake
				au BufWritePost *.elm ElmFormat
    endif
augroup END

let g:python_host_prog = $HOME."/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog = $HOME."/.pyenv/versions/neovim3/bin/python"
