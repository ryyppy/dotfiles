set nocp noet ai cin bs=2 cb=unnamed
set number ruler wrap autoread showcmd showmode fdm=marker


" Disable the creation of backup files (those with ~)
set nobackup nowritebackup

" Fix the tabbing system
set tabstop=4 shiftwidth=4 expandtab
set autoindent
set hlsearch
set splitright

" Initialize installed plugins
call pathogen#infect()

filetype on
filetype plugin on
syntax on

set background=dark
let g:solarized_termcolors=256
colorscheme solarized 

" Airline Configuration (fancy status bar)
set laststatus=2
let g:airline_powerline_fonts=1

" Syntastic Configuration
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0 " don't check on :wq and :x
let g:syntastic_enable_signs=1 " errors on left side

" vim-javascript Configuration
let javascript_ignore_javaScriptdoc=0

" Ultisnip Configuration
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Tagbar Configuration
let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' } 

" YouCompleteMe Configuration
" let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Tern_for_vim Configuration
" let g:tern_map_keys=1

" NERDtree configuration
let g:NERDTreeDirArrows=0 " fixes weird characters as list arrows
" autocmd vimenter * NERDTree " open automatically on VIM startup

" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

"imap <C-Q> <Plug>snipMateNextOrTrigger
"smap <C-Q> <Plug>snipMateNextOrTrigger

" YouCompleteMe needs version 7.4 or higher
if v:version < '704' || !has('python')
    call add(g:pathogen_disabled, 'YouCompleteMe')
endif

" Enable jshint checker, if jshint is available
if executable('jshint')
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_javascript_jshint_conf='$HOME/.jshintrc'
endif


