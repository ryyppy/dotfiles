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
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'lukaszb/vim-web-indent'

" YouCompleteMe 
if has('python')
    if v:version >= '704' 
        Bundle 'Valloric/YouCompleteMe'
    endif
endif

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
filetype plugin indent on
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

" Mustache-Handlebar
let g:mustache_abbreviations = 1

" Syntastic Configuration

let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0 " don't check on :wq and :x
let g:syntastic_enable_signs=1 " errors on left side
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
    
if executable('jshint')
    let g:syntastic_javascript_checkers=['jshint']
    
    function s:find_jshintrc(dir)
        let l:found = globpath(a:dir, '.jshintrc')
        if filereadable(l:found)
            return l:found
        endif

        let l:parent = fnamemodify(a:dir, ':h')
        if l:parent != a:dir
            return s:find_jshintrc(l:parent)
        endif

        return "~/.jshintrc"
    endfunction

    function UpdateJsHintConf()
        let l:dir = expand('%:p:h')
        let l:jshintrc = s:find_jshintrc(l:dir)
        let g:syntastic_javascript_jshint_conf = l:jshintrc
    endfunction

    " Finds and sets the nearest .jshintrc file
    " au BufEnter * call UpdateJsHintConf()
endif
