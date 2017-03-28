" vim: set foldmethod=marker foldlevel=0:
" ============================================================================
" .vimrc of Alistair Stead {{{
" ============================================================================

let s:darwin = has('mac')

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

if !has('nvim')
  Plug 'tpope/vim-sensible'
endif

" EDITOR
Plug 'editorconfig/editorconfig-vim'

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-git'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'   }
Plug 'wellle/tmux-complete.vim'
Plug 'rizzatti/dash.vim'
Plug 'kana/vim-smartinput'
Plug 'Lokaltog/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/BufOnly.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'alvan/vim-closetag', { 'for': [ 'html', 'phtml', 'eruby' ] }
Plug 'vim-scripts/utl.vim'
Plug 'dietsche/vim-lastplace'

" BROWSING
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

" Plug 'vim-airline/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" COLOURS
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
Plug 'ryanoasis/vim-devicons'

" background utils
Plug 'jaawerth/nrun.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'w0rp/ale'

" TESTING
Plug 'neomake/neomake'
Plug 'benmills/vimux'
Plug 'janko-m/vim-test'

" GIT
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" SEARCH
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" LANG
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color', { 'for': [ 'css', 'less', 'sass' ] }
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
" elixir
Plug 'elixir-lang/vim-elixir', { 'for': 'elixir' }
Plug 'slashmili/alchemist.vim', { 'for': 'elixir' }
" phoenix
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
" elm
Plug 'elmcast/elm-vim', { 'for': 'elm' }
Plug 'mattn/emmet-vim', { 'for': [ 'html', 'eruby', 'twig' ] }
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install -g tern' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'docker/docker'

" LINT
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

" base
let mapleader      = ' '
let maplocalleader = ' '

augroup vimrc
	autocmd!
augroup END

set nocompatible                      " vim, not vi
syntax on                             " syntax highlighting
filetype plugin indent on             " try to recognise filetype and load plugins and indent files

" interface
set background=dark                   " tell vim what the background color looks like
set colorcolumn=100                   " show a column at 100 chars
" set cursorline                        " highlight current line
set laststatus=2                      " enable airline on open
set noshowmode                        " don't show mode as airline already does
set number                            " show line numbers
set relativenumber                    " show relative line numbers
set ruler                             " show current position at bottom
set scrolloff=5                       " keep at least 5 lines above/below
set showcmd                           " show any commands
set sidescroll=1                      " smoother horizontal scrolling
set sidescrolloff=5                   " keep at least 5 lines left/right
set splitbelow                        " create new splits below
set splitright                        " create new splits to the right
set termguicolors                     " enable true colors
set wildmenu                          " enable wildmenu
set wildmode=longest:full,full        " configure wildmenu

" whitespace
set noexpandtab                       " use spaces instead of tabs
set shiftwidth=2                      " soft tab width
set nojoinspaces                      " use one space, not two, after punctuation
set softtabstop=2                     " appearance of tabs
set tabstop=2                         " use two spaces for tabs

" text appearance
set list                              " show invisible characters
set listchars=tab:>·,trail:·,nbsp:¬   " but only show useful chaaracters
"  text wrapping
se wrap                               " wrap long lines
se textwidth=100                      " wrap at column 100
" interaction
set backspace=2                       " make backspace work like most other apps
set mouse=""                          " turn off the mouse
set mousehide                         " hide the mouse cursor while typing
set whichwrap=b,s,h,l,<,>,[,]         " backspace and cursor keys wrap too
" text selection
set iskeyword+=-                      " Makes foo-bar considered one word
" searching
set hlsearch                          " highlight search matches
set ignorecase                        " set case insensitive searching
set incsearch                         " find as you type search
set smartcase                         " case sensitive searching when not all lowercase

" background processes
set autoread                          " update file when changed outside of vim
set autoindent                        " copy indentation from the previous line for new line
set history=1000                       " store last 200 commands as history
set lazyredraw                        " no unneeded redraws
set nobackup                          " don't save backups
set noerrorbells                      " no error bells please
set noswapfile                        " no swapfiles
set nowritebackup                     " don't save a backup while editing
set ttyfast                           " indicates a fast terminal connection

" character encoding
if !&readonly
  set fileencoding=utf-8
endif

" Set split separator to Unicode box drawing character
set fillchars=vert:│
set encoding=utf8

if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

"  THEME OPTIONS
" Molokai
let g:rehash256=1
colorscheme molokai

"  FOLDING
se foldmethod=syntax
se foldlevel=99

" AUTOCOMPLETION
se wildcharm=<tab>
se wildmode=full
se completeopt=menuone,preview
" set complete=.,w,b,u,t
set complete-=i
" enable omni syntax completion
set omnifunc=syntaxcomplete#Complete
inoremap <c-l> <c-x><c-l>


"se formatprg=par
"se formatoptions+=tca

set pastetoggle=<F9>
set modelines=2

" nvim integration with system clipboard
" yank to clipboard
if has('clipboard')
	"set clipboard=unnamed
	set clipboard+=unnamedplus
endif

" Keep the cursor on the same column
set nostartofline

highlight htmlArg gui=italic
highlight Comment gui=italic
highlight Type    gui=italic
highlight htmlArg cterm=italic
highlight Comment cterm=italic
highlight Type    cterm=italic

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
	nnoremap <C-a> <nop>
	nnoremap <Leader><C-a> <C-a>
endif

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Tag stack
nnoremap g[ :pop<cr>

" Jump list (to newer position)
nnoremap <C-p> <C-i>

" <F10> | NERD Tree
nnoremap <F10> :NERDTreeToggle<cr>

" <F11> | Tagbar
if v:version >= 703
	inoremap <F11> <esc>:TagbarToggle<cr>
	nnoremap <F11> :TagbarToggle<cr>
	let g:tagbar_sort = 0
endif

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay (recursive map due to peekaboo)
nmap Q @q

" Zoom
function! s:zoom()
	if winnr('$') > 1
		tab split
	elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
									\ 'index(v:val, '.bufnr('').') >= 0')) > 1
		tabclose
	endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" ----------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------
if has('nvim')
	tnoremap <a-a> <esc>a
	tnoremap <a-b> <esc>b
	tnoremap <a-d> <esc>d
	tnoremap <a-f> <esc>f
endif

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" <tab> / <s-tab> / <c-v><tab> | super-duper-tab
" ----------------------------------------------------------------------------
function! s:can_complete(func, prefix)
	if empty(a:func)
		return 0
	endif
	let start = call(a:func, [1, ''])
	if start < 0
		return 0
	endif

	let oline  = getline('.')
	let line   = oline[0:start-1] . oline[col('.')-1:]

	let opos   = getpos('.')
	let pos    = copy(opos)
	let pos[2] = start + 1

	call setline('.', line)
	call setpos('.', pos)
	let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
	call setline('.', oline)
	call setpos('.', opos)

	return !empty(type(result) == type([]) ? result : result.words)
endfunction

function! s:feedkeys(k)
	call feedkeys(a:k, 'n')
	return ''
endfunction

function! s:super_duper_tab(pumvisible, next)
	let [k, o] = a:next ? ["\<c-n>", "\<tab>"] : ["\<c-p>", "\<s-tab>"]
	if a:pumvisible
		return s:feedkeys(k)
	endif

	let line = getline('.')
	let col = col('.') - 2
	if line[col] !~ '\k\|[/~.]'
		return s:feedkeys(o)
	endif

	let prefix = expand(matchstr(line[0:col], '\S*$'))
	if prefix =~ '^[~/.]'
		return s:feedkeys("\<c-x>\<c-f>")
	endif
	if s:can_complete(&omnifunc, prefix)
		return s:feedkeys("\<c-x>\<c-o>")
	endif
	if s:can_complete(&completefunc, prefix)
		return s:feedkeys("\<c-x>\<c-u>")
	endif
	return s:feedkeys(k)
endfunction

if has_key(g:plugs, 'ultisnips')
	" UltiSnips will be loaded only when tab is first pressed in insert mode
	if !exists(':UltiSnipsEdit')
		inoremap <silent> <Plug>(tab) <c-r>=plug#load('ultisnips')?UltiSnips#ExpandSnippet():''<cr>
		imap <tab> <Plug>(tab)
	endif

	let g:SuperTabMappingForward  = "<tab>"
	let g:SuperTabMappingBackward = "<s-tab>"
	function! SuperTab(m)
		return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>",
													 \ a:m == 'n' ? "\<tab>" : "\<s-tab>")
	endfunction
else
	inoremap <silent> <tab>   <c-r>=<SID>super_duper_tab(pumvisible(), 1)<cr>
	inoremap <silent> <s-tab> <c-r>=<SID>super_duper_tab(pumvisible(), 0)<cr>
endif

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" Dash
" ----------------------------------------------------------------------------
nnoremap <leader>d :Dash<cr>

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>

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

" Movement tuning
nnoremap j     gj
nnoremap k     gk
nnoremap <tab> %
vnoremap <tab> %
vnoremap <     <gv
vnoremap >     >gv
" make moving to beginning and end of lines easier
" noremap h ^
" noremap l $

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
" copy all
nnoremap <leader>y ggvgy<cr>

" MIX
map <Leader>mdg :!mix deps.get<cr>

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================
"
" ----------------------------------------------------------------------------
" vim-plug extension
" ----------------------------------------------------------------------------
function! s:plug_gx()
	let line = getline('.')
	let sha  = matchstr(line, '^  \X*\zs\x\{7}\ze ')
	let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
											\ : getline(search('^- .*:$', 'bn'))[2:-2]
	let uri  = get(get(g:plugs, name, {}), 'uri', '')
	if uri !~ 'github.com'
		return
	endif
	let repo = matchstr(uri, '[^:/]*/'.name)
	let url  = empty(sha) ? 'https://github.com/'.repo
											\ : printf('https://github.com/%s/commit/%s', repo, sha)
	call netrw#BrowseX(url, 0)
endfunction

function! s:scroll_preview(down)
	silent! wincmd P
	if &previewwindow
		execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
		wincmd p
	endif
endfunction

function! s:plug_doc()
	let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
	if has_key(g:plugs, name)
		for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
			execute 'tabe' doc
		endfor
	endif
endfunction

function! s:setup_extra_keys()
	" PlugDiff
	nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
	nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
	nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
	nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
	nmap <silent> <buffer> <c-j> <c-n>o
	nmap <silent> <buffer> <c-k> <c-p>o

	" gx
	nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>

	" helpdoc
	nnoremap <buffer> <silent> H  :call <sid>plug_doc()<cr>
endfunction

autocmd vimrc FileType vim-plug call s:setup_extra_keys()

let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'


" ----------------------------------------------------------------------------
" editorconfig
" ----------------------------------------------------------------------------
let g:editorconfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ----------------------------------------------------------------------------
" MatchParen delay
" ----------------------------------------------------------------------------
let g:matchparen_insert_timeout=5

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nnoremap <leader>gs  :Gstatus<CR>gg<c-n>
nnoremap <leader>ga  :Gwrite<CR>
nnoremap <leader>gh  :Gbrowse!<CR>
nnoremap <leader>gc  :Gcommit --verbose<CR>
nnoremap <leader>grm :Gremove<CR>
nnoremap <leader>gmv :Gmove<CR>

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

" xmap <Leader><Enter>   <Plug>(LiveEasyAlign)
" nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

" ----------------------------------------------------------------------------
" splitjoin
" ----------------------------------------------------------------------------
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

"" ----------------------------------------------------------------------------
" vim-airline/vim-airline
" ----------------------------------------------------------------------------
let g:airline#extensions#syntastic#enabled = 0
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = ' '
let g:airline_right_sep = '«'
let g:airline_right_sep = ' '
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.whitespace = ''

"" ----------------------------------------------------------------------------
" ale
"" ----------------------------------------------------------------------------
" wait a bit before checking syntax in a file, if typing
" let g:ale_lint_delay = 5000
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

"" ----------------------------------------------------------------------------
" close-tag
"" ----------------------------------------------------------------------------
let g:closetag_filenames = "*.html,*.erb"

"" ----------------------------------------------------------------------------
" Ack
nnoremap <expr><leader>a ":Ack! "
"" ----------------------------------------------------------------------------

"" ----------------------------------------------------------------------------
" Tabular
"" ----------------------------------------------------------------------------
nnoremap <leader><tab><tab> :Tab /
nnoremap <leader><tab>= :Tab /=<cr>
nnoremap <leader><tab>: :Tab /:\zs<cr>
nnoremap <leader><tab>> :Tab /=><cr>
vnoremap <leader><tab> :Tab /
vnoremap <leader><tab>= :Tab /=<cr>
vnoremap <leader><tab>: :Tab /:\zs<cr>
vnoremap <leader><tab>> :Tab /=><cr>

"" ----------------------------------------------------------------------------
" Nerdtree
"" ----------------------------------------------------------------------------
map <C-\> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 24
let g:NERDTreeMinimalUI = 1

" ----------------------------------------------------------------------------
" syntastic
" ----------------------------------------------------------------------------
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1


"" ----------------------------------------------------------------------------
" vim-tmux-navgator
"" ----------------------------------------------------------------------------
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

"" ----------------------------------------------------------------------------
"  EASYMOTION
"" ----------------------------------------------------------------------------
let g:EasyMotion_leader_key='t'
let g:easymotion_smartcase = 1
let g:easymotion_keys='qwertyuiopasdfghjklzxcvbnm'

"" ----------------------------------------------------------------------------
"  NEOMAKE
"" ----------------------------------------------------------------------------
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

"" ----------------------------------------------------------------------------
"  TESTS
"" ----------------------------------------------------------------------------
nmap <silent> <leader>tt :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>
let test#strategy = "make"

"" ----------------------------------------------------------------------------
" POLYGLOT
"" ----------------------------------------------------------------------------
let g:polyglot_disabled = ['elm', 'elixir']

"" ----------------------------------------------------------------------------
" Alchemist
"" ----------------------------------------------------------------------------
let g:alchemist_tag_stack_map = '<C-Q>'

"" ----------------------------------------------------------------------------
" Elm
"" ----------------------------------------------------------------------------
let g:elm_format_autosave = 1
let g:elm_detailed_complete = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_format_fail_silently = 1
let g:elm_browser_command = 'open'
let g:elm_make_show_warnings = 1
let g:elm_setup_keybindings = 1

"" ----------------------------------------------------------------------------
" php
"" ----------------------------------------------------------------------------
let g:php_folding=1
let php_noShortTags = 1

nnoremap <leader>u :call PhpInsertUse()<cr>
nnoremap <leader>e :call PhpExpandClass()<cr>

"" ----------------------------------------------------------------------------
" Deoplete
"" ----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#max_list = 5
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'file', 'neosnippet']
let g:deoplete#omni#functions = {}
let g:deoplete#omni#input_patterns = {}
" jsx
let g:deoplete#omni#functions.javascript = ['tern#complete']
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'ternjs']
" Elm support
" h/t https://github.com/ElmCast/elm-vim/issues/52#issuecomment-264161975
let g:deoplete#sources.elm = ['buffer', 'omni'] + g:deoplete#sources._
let g:deoplete#omni#functions.elm = ['elm#Complete']
let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
" let g:deoplete#disable_auto_complete = 1

"" ----------------------------------------------------------------------------
" Markdown
"" ----------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.md set spell | set lbr | set nonu
let g:markdown_fenced_languages = ['html', 'json', 'css', 'javascript', 'elm', 'vim']

"" ----------------------------------------------------------------------------
" BEHAT
"" ----------------------------------------------------------------------------
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

" }}}
" ============================================================================
" FZF {{{
" ============================================================================

nnoremap <c-t> :FZF<cr>

if has('nvim')
	let $FZF_DEFAULT_OPTS .= ' --inline-info'
	let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
endif

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options = printf('--preview "%s {} | head -'.&lines.'"',
			\ g:plugs['fzf.vim'].dir.'/bin/preview.rb')

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

command! Plugs call fzf#run({
	\ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
	\ 'options': '--delimiter / --nth -1',
	\ 'down':    '~40%',
	\ 'sink':    'Explore'})

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" ConnectChrome
" ----------------------------------------------------------------------------
if s:darwin
	function! s:connect_chrome(bang)
		augroup connect-chrome
			autocmd!
			if !a:bang
				autocmd BufWritePost <buffer> call system(join([
				\ "osascript -e 'tell application \"Google Chrome\"".
				\               "to tell the active tab of its first window\n",
				\ "  reload",
				\ "end tell'"], "\n"))
			endif
		augroup END
	endfunction
	command! -bang ConnectChrome call s:connect_chrome(<bang>0)
endif

" ----------------------------------------------------------------------------
" AutoSave
" ----------------------------------------------------------------------------
function! s:autosave(enable)
	augroup autosave
		autocmd!
		if a:enable
			autocmd TextChanged,InsertLeave <buffer>
						\  if empty(&buftype) && !empty(bufname(''))
						\|   silent! update
						\| endif
		endif
	augroup END
endfunction

command! -bang AutoSave call s:autosave(<bang>1)


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

let g:python_host_prog = $HOME."/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog = $HOME."/.pyenv/versions/neovim3/bin/python"

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup elixir
  autocmd!
  " autocmd BufWritePre *.ex call Indent()
  " autocmd BufWritePre *.exs call Indent()
  "
  " Sadly, I can't enable auto-indent for elixir because it messes up my heredoc
  " indentation for code sections and it has a couple of other issues :(
  autocmd BufNewFile,BufRead *.ex setlocal formatoptions=tcrq
  autocmd BufNewFile,BufRead *.exs setlocal formatoptions=tcrq
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal formatoptions=tcrq
  autocmd FileType markdown setlocal spell spelllang=en
augroup END

augroup git
  autocmd!
	autocmd FileType markdown setlocal spell spelllang=en
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal colorcolumn=+1
augroup END

augroup vimrc
	au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  au FileType helpfile setlocal nonumber

	" IndentLines
	au FileType slim IndentLinesEnable

	" File types
	au BufNewFile,BufRead *.icc               set filetype=cpp
	au BufNewFile,BufRead *.pde               set filetype=java
	au BufNewFile,BufRead *.coffee-processing set filetype=coffee
	au BufNewFile,BufRead Dockerfile*         set filetype=dockerfile
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


	" Included syntax
	" au FileType,ColorScheme * call <SID>file_type_handler()

	" Fugitive
	au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

	" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
	au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
	au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

	" Unset paste on InsertLeave
	au InsertLeave * silent! set nopaste

  " Autocalls
  au BufWrite * :call <sid>MkdirsIfNotExists(expand('<afile>:h'))
  au BufWritePost,BufEnter * Neomake
  au BufWritePost *.elm ElmFormat

  " Close preview window
	if exists('##CompleteDone')
		au CompleteDone * pclose
	else
		au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
	endif

	" Automatic rename of tmux window
	if exists('$TMUX') && !exists('$NORENAME')
		au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
		au VimLeave * call system('tmux set-window automatic-rename on')
	endif
augroup END

" ----------------------------------------------------------------------------
" Help in new tabs
" ----------------------------------------------------------------------------
function! s:helptab()
	if &buftype == 'help'
		wincmd T
		nnoremap <buffer> q :q<cr>
	endif
endfunction
autocmd vimrc BufEnter *.txt call s:helptab()

" }}}
