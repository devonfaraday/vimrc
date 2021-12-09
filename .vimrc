" This is a suggested vimrc managed by puppet. Copy it into ~/.vimrc as a starting point
" NOTE: If you don't have vim-plug locally yet, run the following to install vim-plug:
"     curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Check the source out here: https://github.com/junegunn/vim-plug
"
" To install these plugins: vim +PlugInstall

""" vim-plug init and install directory
call plug#begin('~/.vim/plugged')
  """ General Helpful Plugins
  " Enhance % goto, allows if/endif and <tag> to </tag> matching in html, wish this was built in by default
  Plug 'adelarsq/vim-matchit'
  " Highlights rogue ws. Run :EraseBadWhitespace to autoclean
  Plug 'bitc/vim-bad-whitespace'
  " QoL for editing several files:  <Leader>bt to toggle it open/closed, see github for more
  Plug 'jlanzarotta/bufexplorer'
  " :TagbarToggle provides a visual outline of the tags in the current buffer
  Plug 'majutsushi/tagbar'
  " Provides commands for auto-surrounding text objects with quotes, brackets,
  " html tags, and more - check out github on this one, real cool stuff
  Plug 'tpope/vim-surround'
  " Requires 'sudo apt install ack', powerful code search tool
  Plug 'mileszs/ack.vim'
  " Turns 'gc' in normal mode into a comment toggle. gcl to comment current line, 4gcj to toggle current + 4 lines down
  Plug 'tpope/vim-commentary'
  " Excellent file explorer plugin, lazy-loaded until invoked with :NERDTreeToggle (or keybind)
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  " Syntax enhancements
  Plug 'scrooloose/syntastic'
  " Core debugger tool integration for PHP
  Plug 'vim-vdebug/vdebug'
  " Excellent plugin, only loaded for the go filetype
  Plug 'fatih/vim-go', { 'for': 'go' }

  """ QoL plugins, recommended but not important
  " Excellent git integration
  Plug 'tpope/vim-fugitive'
  " Color approximator to allow greater color flexibility
  Plug 'vim-scripts/CSApprox'
  " Allows auto-un-highlight upon action
  Plug 'romainl/vim-cool'
  " QoL status bar upgrade
  Plug 'itchyny/lightline.vim'
  " Color schemes
  Plug 'crusoexia/vim-monokai'
call plug#end()


""" Standard VIM Settings
set nocompatible        " Some old settings that are recommended to be set early
filetype plugin indent on
syntax on
let &t_Co=256           " Force better colorage on some systems
" Custom vim session file paths: The // preserves full paths for safe editing of like-named files
set backupdir^=/tmp//   " Prepend /tmp to .bak file location list
set dir^=/tmp//         " Prepend /tmp to .swp file location list
" Tab Settings
set autoindent          " Enforce autoindenting
set smartindent         " Companion to autoindent
set expandtab           " Uses spaces instead of tabs
set shiftround          " Round < and > indenting to multiple of shiftwidth
set shiftwidth=2        " Space-width for autoindent, >>, <<, ==, etc.
set softtabstop=2       " 2 spaces per tab
set tabstop=2           " Tabs are represented by X spaces
" General Settings
set autoread            " Auto-reopen unmodified files when changed
set backspace=indent,eol,start " Backspace all the things
set confirm             " Instead of failing a cmd due to unsaved changes, just ask
set history=50          " Keep 50 lines of command line history
set hlsearch            " Visibility, works nice with vim-cool
set ignorecase          " Caseless searching
set smartcase           " Case-sensitive searching when mixing case
set incsearch           " Search with / auto-searches as characters are typed
set laststatus=2        " Always show status bar above console line
set lazyredraw          " Dont update screen during macro/script exec, smoother UI
set linebreak           " Smarter wrapping, dont break words
set mouse=a             " If we have a mouse, make it work
set nofixendofline      " Disable auto-removal of extra final newlines
set nowrap              " Soft wrap like a good taco (set !nowrap)
set noshowmode          " For lightline, disable to get classic status bar back
set nu                  " Always show line nums
" set rnu                 " Show relative line numbers above/below current line, HUGE slowdown on WSL though
set ruler               " Show the cursor position all the time
set scrolloff=4         " Buffer of lines at top/bottom of cursor
set showcmd             " Display incomplete commands
set synmaxcol=200       " Prevents syntax highlighting beyond a certain line length, so sql export files won't break vim.
set tabpagemax=64       " Handle more than 10 max tabs at a time, USE :Xgt where X is a number to go to that numbered tab, :ls to list tabs
" set tbs                 " Use binary search for tags, only works with universal-ctags
set tc=match            " Tag lookup = MATCH case (other options include followic and ignore)
set wildmode=longest,full " Complete to longest common string first, then open selection menu
" Use a faster grep if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

""" Plugin Settings and Configuration
" QoL nerdtree tweaks
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" For lightline plugin: relies on a couple functions defined below
let g:lightline = {
\   'colorscheme':'PaperColor',
\   'component_function': {
\     'fileformat': 'LightlineFileformat',
\     'filetype': 'LightlineFiletype',
\   },
\   'mode_map': {
\     'n' : 'N',
\     'i' : 'I',
\     'R' : 'R',
\     'v' : 'V',
\     'V' : 'VL',
\     "\<C-v>": 'VB',
\     'c' : 'C',
\     's' : 'S',
\     'S' : 'SL',
\     "\<C-s>": 'SB',
\     't': 'T',
\   }
\ }
" Additional plugin configuration
let g:CoolTotalMatches = 1
let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
let g:syntastic_check_on_open = 0
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


""" UI, colorscheme, custom highlights
" Set colorscheme here
colorscheme ron
" Completion menu UI tweaks to make it tolerable instead of hot pink
highlight Pmenu ctermbg=gray guibg=gray
highlight Pmenu ctermfg=black guifg=black
highlight PmenuSel ctermbg=black guibg=black
highlight PmenuSel ctermfg=cyan guifg=cyan


""" Custom Functions
" Just for lightline, if enabled
function! LightlineFileformat()
  return winwidth(0) > 80 ? &fileformat : ''
endfunction
function! LightlineFiletype()
  return winwidth(0) > 80 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
" Smarter next/prev selection
function! QuickNext()
  if exists( '*tabpagenr' ) && tabpagenr('$') != 1
    execute ":tabnext"
  else
    execute ":bnext"
  endif
endfunction
function! QuickPrev()
  if exists( '*tabpagenr' ) && tabpagenr('$') != 1
    execute ":tabprevious"
  else
    execute ":bprev"
  endif
endfunction
" Smarter nerdtree toggle
function! OpenOrFocusNERDTree()
  if exists('t:NERDTreeBufName')
    NERDTreeFocus
  else
    NERDTreeToggle
  endif
endfunction
" Set working directory to git project root if possible, or dir of current file
function! CDProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction
" Fixing F1 frustrations, cheers to vim.fandom
function! HelpHelper()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction
" Fast file purging
function! DeleteAndCloseFile()
  :call delete(expand('%'))
  :bdelete!
endfunction


""" Leader customization and related commands
let g:mapleader = ","
let mapleader = ","

""" Leader keymap tweaks (normal mode)
" Quick write alias
nnoremap <leader>w :w<CR>
" nnoremap <leader>q :wq<CR>
" Quick spell checker
nnoremap <leader>ss :setlocal spell!<cr>
" Set vim cwd to file's dir
nnoremap <leader>cdb :cd %:p:h<CR>:pwd<CR>
" Set vim cwd to git root (fallback to current file's dir)
nnoremap <leader>cdp :call CDProjectRoot()<CR>
" Top level search from current dir (requires ack)
nnoremap <leader>a yiw:Ack! <C-r>"<CR>
" In a location list, jump to next or prev error
nnoremap <leader>ln :lne<CR>
nnoremap <leader>lp :lp<CR>
" Fast access to quick-delete function
nnoremap <leader>rm :call DeleteAndCloseFile()
" Fast window-splitting
nnoremap <Leader>j <C-w>j
nnoremap <Leader>h <C-w>h
nnoremap <Leader>n <Esc>:vs<CR>
" Split window resize guide
"     <C-w>+ increases height, <C-w>- decreases height
"     <C-w>> increases width, <C-w>< decreases width
" Fast nerdtree toggle
nnoremap <leader>nt :call OpenOrFocusNERDTree()<Enter>
nnoremap <leader>ct :NERDTreeToggle<Enter>
" Fast tagbar toggle
nnoremap <leader>tt :TagbarToggle<Enter>
" Fast bash
nnoremap <leader>sh :shell<Enter>


""" Normal mode keymap tweaks
" Toggle help instead of blindly opening it
noremap <F1> :call HelpHelper()<CR>
" Ctrl-N/M/B to navigate vim tabs, adjust to preference
nnoremap <C-n> <Esc>:call QuickNext()<CR>
nnoremap <C-m> <Esc>:call QuickPrev()<CR>
" Horizontal scroll trick
nnoremap <S-ScrollWheelUp> <ScrollWheelLeft>
nnoremap <S-ScrollWheelDown> <ScrollWheelRight>
" Smarter 'shift+left/right' bindings
nnoremap H ^
nnoremap L $
" Center current search result in screen
nnoremap n nzz
nnoremap N nzz
" Stop search highlighting upon edit
nnoremap a :noh<cr>a
nnoremap c :noh<cr>c
nnoremap i :noh<cr>i
nnoremap o :noh<cr>o
nnoremap O :noh<cr>O
" Search global tags on go-to-tag
nnoremap <C-]> g<C-]>
" Optional way to open tag search in new tab
nnoremap <C-S-]> :execute 'tab tag '.expand('<cword>')<CR>
" Split-window quick nav with Ctrl
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
" Split window resize guide
"     <C-w>+ increases height, <C-w>- decreases height
"     <C-w>> increases width, <C-w>< decreases width

""" Suggested but disabled keybinds
" Consistent Y with rest of things (yy yanks current line anyways)
" nnoremap Y y$
" Fast command prompt
" nnoremap <space> :


""" Insert mode mappings
" Usually don't need help in insert mode when reaching for escape
inoremap <F1> <Esc>


""" Custom Commands
" Sudo write shortcut
command! W w !sudo tee % > /dev/null
" Quickformat a json document
command! Fjson %!python -m json.tool


""" Filetype specific config and mappings
augroup filetypecustomization
  autocmd!
  au FileType go nnoremap <leader>gt <Plug>(go-test)
  au FileType go nnoremap <leader>gb <Plug>(go-build)
  au FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab
  au FileType markdown setlocal tabstop=4 shiftwidth=4
  " Autoformat golang on save to prevent build failures
  au BufWritePost *.go !gofmt -w %
  " PHP-specific indentation
  "au FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
augroup templatesyntax
  " Syntax highlighting for template files
  au BufReadPost *.conf.tmpl set syntax=conf
  au BufReadPost *.html.tmpl set syntax=html
  au BufReadPost *.php.tmpl set syntax=php
  au BufReadPost *.sh.tmpl set syntax=bash
  au BufReadPost *.xml.tmpl set syntax=xml
  au BufReadPost *.yaml.tmpl set syntax=yaml
augroup END

