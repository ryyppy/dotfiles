set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Require Vundle to manage itself
Bundle 'gmarik/vundle'

" Load Bundles
Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'scrooloose/nerdtree'
Bundle 'moll/vim-node'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'marijnh/tern_for_vim'
Bundle 'SirVer/ultisnips'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'pangloss/vim-javascript'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'


set noet ai cin bs=2 cb=unnamed
set number ruler wrap autoread showcmd showmode fdm=marker

" Disable the creation of backup files (those with ~)
set nobackup nowritebackup

" Fix the tabbing system
set tabstop=4 shiftwidth=4 expandtab
set autoindent
set hlsearch
set splitright

"Enable the neat filetype and syntax sugar
filetype on
filetype plugin on
syntax on

"Set color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized 

" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Airline (fancy status bar)
set laststatus=2
let g:airline_powerline_fonts=1

" vim-javascript 
let javascript_ignore_javaScriptdoc=0

" Ultisnip 
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" Tagbar 
let g:tagbar_type_javascript = { 'ctagsbin' : 'jsctags' } 

" vim-json 
let g:vim_json_syntax_conceal=0

" NERDtree 
let g:NERDTreeDirArrows=0 " fixes weird characters as list arrows

" YouCompleteMe 
if v:version < '704' || !has('python')
    call add(g:pathogen_disabled, 'YouCompleteMe')
endif

" Syntastic Configuration
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0 " don't check on :wq and :x
let g:syntastic_enable_signs=1 " errors on left side

if executable('jshint')
    let g:syntastic_javascript_checkers=['jshint']
    let g:syntastic_javascript_jshint_conf='$HOME/.jshintrc'
endif
