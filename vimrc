set nocp noet ai cin bs=2 cb=unnamed
set number ruler wrap autoread showcmd showmode fdm=marker


" Disable the creation of backup files (those with ~)
set nobackup nowritebackup

" Fix the tabbing system
set tabstop=4 shiftwidth=4 expandtab
set autoindent

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

let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_jshint_conf='$HOME/.jshintrc'

" YouCompleteMe Configuration
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Tern_for_vim Configuration
" let g:tern_map_keys=1

" NERDtree configuration
let g:NERDTreeDirArrows=0 " fixes weird characters as list arrows
" autocmd vimenter * NERDTree " open automatically on VIM startup


" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Initialize installed plugins
call pathogen#infect()
