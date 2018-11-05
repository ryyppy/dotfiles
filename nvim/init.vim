""""
" Lots of inspiration was drawn from Andrey Popp's vimrc:
" https://gist.github.com/andreypopp/2527570ff0ad761da39d62ebb45a0152
""""

if !1 | finish | endif

"""" prelude

set nocompatible

syntax on

filetype on
filetype plugin on
filetype plugin indent on

set langmenu=en_US.UTF-8

"""" Fixes some background color issues with vim & tmux
let &t_ut=''

silent! if plug#begin('~/.vim/plugged')
  Plug 'Alvarocz/vim-fresh'
  Plug 'pbrisbin/vim-colors-off' 

  Plug 'itchyny/lightline.vim'

  Plug 'tpope/vim-surround'
  Plug 'airblade/vim-gitgutter'
  Plug 'haya14busa/incsearch.vim'

  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'andreypopp/fzf-merlin'

  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'

  Plug 'vim-scripts/Rename'
  Plug 'sbdchd/neoformat'
  Plug 'reasonml-editor/vim-reason-plus'
  call plug#end()
endif


""""" Some basic stuff
filetype on
filetype plugin on
filetype plugin indent on
syntax on

set tabstop=2 shiftwidth=2 expandtab
set autoindent smartindent nocindent indentexpr=
set hlsearch
set splitright
set relativenumber
set wildignore=*.swp,*.bak,*.pyc,*.class,*.egg-info,.git,.svn,.hg,.bzr,.env,node_modules,.sass-cache

set completeopt-=preview
set completeopt+=menuone
set completeopt+=noinsert,noselect
set shortmess+=c

" Required for clipboard sharing
set clipboard+=unnamed

au FileType python setl sw=4 sts=4 et
au FileType coffee setl sw=2 sts=2 et
au FileType elm setl sw=2 sts=2 et
au Filetype javascript setl sw=2 sts=2 et

""""" appearance

set guioptions-=T
set guioptions-=r


set termguicolors
set background=dark
colorscheme fresh

" Make visual selection more visible
hi Visual  guifg=#000000 guibg=#FFFFFF gui=none

"""" leader config

let g:mapleader=','
let g:maplocalleader='\\'

"""" vimrc shortcuts

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
map <silent> <leader>/ :nohlsearch<CR>

""""" Text editing keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

""""" Neoformat

let g:neoformat_javascript_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin',
                  \'--no-bracket-spacing',
                  \'--single-quote',
                  \'--trailing-comma', 'all',
                  \'--print-width', '90',
                  \'--jsx-bracket-same-line'],
        \ 'stdin': 1,
        \ }

let g:neoformat_enabled_javascript = ['prettier']

let g:neoformat_reason_refmt = {
        \ 'exe': 'refmt',
        \ 'stdin': 1,
        \ 'args': ['--print-width 80'],
        \ }

let g:neoformat_enabled_reason = ['refmt']

let g:neoformat_ocaml_ocpindent = {
        \ 'exe': 'ocp-indent',
        \ 'args': ['--config strict_comments=true'],
        \ }

let g:neoformat_ocaml_ocamlformat = {
        \ 'exe': 'ocamlformat',
        \ 'args': ['--inplace'],
        \ 'replace': 1,
        \ 'stdin': 0,
        \ }

let g:neoformat_enabled_ocaml = ['ocp-indent']

"augroup fmt
"  autocmd!
"  au BufWritePre * Neoformat
"augroup END

""" LanguageClient

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

""""" incsearch
let g:incsearch#auto_nohlsearch = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

""""" fzf

nnoremap <C-p> <Esc>:Files<CR>
nnoremap <C-b> <Esc>:Buffers<CR>
nnoremap <C-e> <Esc>:Commands<CR>
nnoremap <C-x> <Esc>:Ag<CR>

let g:fzf_layout = { 'window': 'enew' }
 let g:fzf_colors =
 \ { 'fg':      ['fg', 'Normal'],
   \ 'bg':      ['bg', 'Normal'],
   \ 'hl':      ['fg', 'Normal'],
   \ 'fg+':     ['fg', 'Normal'],
   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
   \ 'hl+':     ['fg', 'Normal'],
   \ 'info':    ['fg', 'Normal'],
   \ 'border':  ['fg', 'Normal'],
   \ 'prompt':  ['fg', 'Normal'],
   \ 'pointer': ['fg', 'Normal'],
   \ 'marker':  ['fg', 'Normal'],
   \ 'spinner': ['fg', 'Normal'],
   \ 'header':  ['fg', 'Normal'] }

let $FZF_DEFAULT_COMMAND = 'ag -l --nocolor
      \ --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore coverage
      \ --ignore build
      \ --ignore node_modules
      \ --ignore site-packages
      \ --ignore "*.egg-info"
      \ --ignore "**/*.pyc"
      \ --ignore "*.pyc"
      \ -g ""'

let $FZF_DEFAULT_OPTS = ''

function! HideStatusBarWhileInFZF()
  set laststatus=0
  autocmd BufLeave <buffer> set laststatus=2
endfunction

if has('nvim') || has('gui_running')
  autocmd! FileType fzf
  autocmd  FileType fzf call HideStatusBarWhileInFZF()
endif

""""" Neoformat

let g:neoformat_javascript_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin',
                  \'--no-bracket-spacing',
                  \'--single-quote',
                  \'--trailing-comma', 'all',
                  \'--print-width', '90',
                  \'--jsx-bracket-same-line'],
        \ 'stdin': 1,
        \ }

let g:neoformat_enabled_javascript = ['prettier']

let g:neoformat_reason_refmt = {
        \ 'exe': 'refmt',
        \ 'stdin': 1,
        \ 'args': ['--print-width 80'],
        \ }

let g:neoformat_enabled_reason = ['refmt']

let g:neoformat_ocaml_ocpindent = {
        \ 'exe': 'ocp-indent',
        \ 'args': ['--config strict_comments=true'],
        \ }
let g:neoformat_ocaml_ocamlformat = {
        \ 'exe': 'ocamlformat',
        \ 'args': ['--inplace'],
        \ 'replace': 1,
        \ 'stdin': 0,
        \ }

let g:neoformat_enabled_ocaml = ['ocp-indent']

map <leader>r :Neoformat<CR>

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
