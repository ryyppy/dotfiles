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

" only use python3 provider
let g:loaded_python_provider = 0

set langmenu=en_US.UTF-8

"""" Fixes some background color issues with vim & tmux
let &t_ut=''

"""" leader config

let mapleader=""
let maplocalleader=','

silent! if plug#begin()
  "" Color Schemes
  Plug 'cormacrelf/vim-colors-github'
  Plug 'Alvarocz/vim-fresh'
  Plug 'pbrisbin/vim-colors-off' 
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  Plug 'cocopon/iceberg.vim'
  Plug 'bluz71/vim-nightfly-guicolors'

  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'

  Plug 'itchyny/lightline.vim'

  Plug 'tpope/vim-surround'
  Plug 'airblade/vim-gitgutter'
  "Plug 'haya14busa/incsearch.vim'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  "Plug 'andreypopp/fzf-merlin'

  Plug 'dhruvasagar/vim-markify'
  Plug '~/Projects/rescript-association/vim-rescript'
  "Plug 'rescript-lang/vim-rescript', {'tag': 'v2.0.1'}
  "Plug 'rescript-lang/vim-rescript', {'branch': 'upgrade-vscode-113'}
  Plug 'jonsmithers/vim-html-template-literals'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'leafgarland/typescript-vim'
  Plug 'tpope/vim-markdown'
  Plug 'ap/vim-css-color'

  Plug 'vim-scripts/Rename'
  Plug 'sbdchd/neoformat'
  Plug 'reasonml-editor/vim-reason-plus'
  Plug 'SirVer/ultisnips'

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
"set relativenumber
set number
set wildignore=*.swp,*.bak,*.pyc,*.class,*.egg-info,.git,.svn,.hg,.bzr,.env,node_modules,.sass-cache

set completeopt-=preview
set completeopt+=menuone
set completeopt+=noinsert,noselect
set shortmess+=c
set nowrap

" Required for clipboard sharing
set clipboard+=unnamed

au FileType python setl sw=4 sts=4 et
au FileType coffee setl sw=2 sts=2 et
au FileType elm setl sw=2 sts=2 et
au Filetype javascript setl sw=2 sts=2 et

""""" appearance

set cursorline
set guioptions-=T
set guioptions-=r

set termguicolors
"set background=light
set background=dark


" For nightfly, we need to fix up a few colors
colorscheme nightfly
hi Conceal guibg=NONE guifg=#a1aab8

"colorscheme iceberg

"""" GITHUB THEME START
"" use a slightly darker background, like GitHub inline code blocks
"let g:github_colors_soft = 0

"" more blocky diff markers in signcolumn (e.g. GitGutter)
"let g:github_colors_block_diffmark = 0

"colorscheme github

"colorscheme github
let g:lightline = { 'colorscheme': 'nightfly' }
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

"""" GITHUB THEME END


""" OWN COMMANDS

" will copy the filepath of the current file relative to its closest git root
" to the clipboard buffer
:command! CopyBufferPath let @+ = LightlineFilename()

""" END OWN COMMANDS


" Make visual selection more visible
hi Visual guifg=#000000 guibg=#FFFFFF gui=none

" Prevent column left to line numbers appear to be lightgrey
highlight SignColumn guibg=NONE 

"""" NERDTree
nnoremap <silent> <leader>f :NERDTreeToggle <Bar> wincmd p<Enter>

let NERDTreeShowHidden = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeMapActivateNode='<Tab>'
let g:NERDTreeWinSize=50

"""" vimrc shortcuts
nnoremap <leader><leader> <C-^>
nmap <silent> <localleader>ev :e $MYVIMRC<CR>
nmap <silent> <localleader>sv :so $MYVIMRC<CR>
nmap <silent> <localleader>eu :UltiSnipsEdit<CR>
map <silent> <localleader>/ :nohlsearch<CR>
nmap <silent> <localleader>ntf :NERDTreeFind<CR>
nmap <silent> <localleader>cbp :CopyBufferPath<CR>

""""" Text editing keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"augroup fmt
"  autocmd!
"  au BufWritePre * Neoformat
"augroup END

""" LanguageClient

" Required for operations modifying multiple buffers like rename.
set hidden
"let g:LanguageClient_serverCommands = {
    "\ 'reason': ['~/bin/reason-language-server.exe'],
    "\ 'ocaml': ['ocaml-language-server', '--stdio'],
    "\ }

"nnoremap <silent> <localleader>gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> <localleader>t :call LanguageClient_textDocument_hover()<cr>

"""" Some MISC Stuff

" Autoread when file has changed (useful for bs.js)
set autoread                                                                                                                                                                                    
autocmd CursorHold * checktime  



"""" CoC LanguageClient

" if hidden is not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"nnoremap <silent> <localleader>gd :call LanguageClient_textDocument_definition()<cr>
"nnoremap <silent> <localleader>t :call LanguageClient_textDocument_hover()<cr>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <localleader>t :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highligt symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

""""" incsearch
set incsearch
"let g:incsearch#auto_nohlsearch = 1

"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
"map n  <Plug>(incsearch-nohl-n)
"map N  <Plug>(incsearch-nohl-N)
"map *  <Plug>(incsearch-nohl-*)
"map #  <Plug>(incsearch-nohl-#)
"map g* <Plug>(incsearch-nohl-g*)
"map g# <Plug>(incsearch-nohl-g#)

""""" fzf

" Emulate Emacs Projectiles file search
nnoremap <C-c>f :Files<CR>
nnoremap <C-c>b <Esc>:Buffers<CR>
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
      \ --ignore "**/node_modules"
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


""""" UltiSnips

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

""""" Neoformat

let g:neoformat_javascript_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin', '--parser=typescript'],
        \ 'stdin': 1,
        \ }

"let g:neoformat_html_prettier = {
        "\ 'exe': 'prettier',
        "\ 'args': ['--stdin', '--parser=html'],
        "\ 'stdin': 1,
        "\ }

"let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
"let g:neoformat_enabled_html = ['prettier']

"let g:neoformat_reason_refmt = {
        "\ 'exe': 'bsrefmt',
        "\ 'stdin': 1,
        "\ 'args': ["--interface=" . (expand('%:e') == "rei" ? "true" : "false")],
        "\ }


"let g:neoformat_enabled_reason = ['refmt']

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

let g:neoformat_enabled_ocaml = ['ocamlformat', 'ocp-indent']

" Useful for debugging
let g:neoformat_verbose = 0

nnoremap <localleader>r :Neoformat<CR>

" Markdown
let g:markdown_fenced_languages = ['ts=typescript', 'css', 'javascript', 'js=javascript', 'json=javascript', 'rescript', 'res=rescript' ]

" vim-rescript config
"-----------------------
" experimental binary for now
"let g:rescript_type_hint_bin="/Users/ryyppy/Projects/rescript-association/reason-language-server/bin.exe"
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>r :RescriptFormat<CR>
"autocmd FileType rescript nnoremap <silent> <buffer> <localleader>t :RescriptTypeHint<CR>
autocmd FileType rescript nnoremap <silent> <buffer> <localleader>b :RescriptBuild<CR>
"autocmd FileType rescript nnoremap <silent> <buffer> gd :RescriptJumpToDefinition<CR>
autocmd FileType javascript,javascript.jsx,typescript nnoremap <silent> <buffer> <localleader>r :CocCommand prettier.formatFile<CR>

set omnifunc=rescript#Complete
