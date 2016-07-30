if &compatible
  set nocompatible
endif

set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('ryyppy/deoplete-flow')
call dein#add('neomake/neomake')

call dein#add('tpope/vim-surround')
call dein#add('Valloric/MatchTagAlways')
call dein#add('tmhedberg/matchit')
call dein#add('ryyppy/nerdcommenter')
call dein#add('scrooloose/nerdtree')
call dein#add('SirVer/ultisnips')
call dein#add('tpope/vim-fugitive')
call dein#add('bling/vim-airline')

call dein#add('pangloss/vim-javascript')
"call dein#add('othree/yajs.vim')
call dein#add('moll/vim-node')
call dein#add('elzr/vim-json')
call dein#add('mxw/vim-jsx')

call dein#add('mephux/bro.vim')
call dein#add('lambdatoast/elm.vim')

call dein#end()

"Own functions
function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

"Some basic stuff
filetype on
filetype plugin on
filetype plugin indent on
syntax on

set expandtab
set tabstop=2 shiftwidth=2
set autoindent smartindent nocindent indentexpr=
set hlsearch
set splitright

au FileType python setl sw=4 sts=4 et
au FileType coffee setl sw=2 sts=2 et
au FileType elm setl sw=2 sts=2 et
au Filetype javascript set sw=2 sts=2 et

set noet ai cin bs=2 cb=unnamed
set number ruler nowrap autoread showcmd showmode fdm=marker

"Set color scheme
set background=dark
colorscheme grb256
set t_Co=256

" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Opening and closing braces
imap <C-F> {<CR>}<C-O>O

" Puts a literal ^I (literal tab character)
:inoremap <S-Tab> <C-V><Tab>

" Git-Commit formatting
autocmd Filetype gitcommit setlocal wrap spell textwidth=72

" MD formatting
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd Filetype markdown setlocal wrap textwidth=80 

" Enable javascript highlighting for flowtype
au BufNewFile,BufRead *.flow set filetype=javascript

" Ultisnip 
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vim-json 
let g:vim_json_syntax_conceal=0

" vim-javascript
let g:javascript_plugin_flow = 1

"""""""""""""""""""""""""
" 	DEOPLETE CONFIG
" - https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/ 
"""""""""""""""""""""""""

" Omnicomplete on CTRL space
" Since iterm will inevitably send a <Nul> on CTRL-Space (because it's not a
" GUI app), we need to make sure that those <Nul> will be mapped to <C-Space>
" instead
inoremap <C-Space> <C-x><C-o>
imap <buffer> <Nul> <C-Space>
smap <buffer> <Nul> <C-Space>

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Enable auto-completion by default
let g:deoplete#enable_at_startup = 1

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


"""""""""""""""""""""""""
" 	NEOMAKE CONFIG
"""""""""""""""""""""""""
let g:eslint_path = StrTrim(system('PATH=$(npm bin):$PATH && which eslint'))
let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

let g:neomake_open_list = 2
let g:neomake_place_signs = 1

let g:neomake_javascript_enabled_makers = []

if g:eslint_path != 'eslint not found'
	let g:neomake_javascript_eslint_exe = g:eslint_path
	let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'eslint']
endif

if g:flow_path != 'flow not found'
	let g:neomake_javascript_flow_exe = g:flow_path
	let g:neomake_javascript_enabled_makers = g:neomake_javascript_enabled_makers + [ 'flow']
	let g:deoplete#sources#flow#flow_bin = g:flow_path
endif

autocmd! BufWritePost * Neomake

"call deoplete#enable_logging("DEBUG", "deoplete.log")
