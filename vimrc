set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Require Vundle to manage itself
Bundle 'gmarik/vundle'

" Load Bundles
" Bundle 'yonchu/accelerated-smooth-scroll'
Bundle 'vim-ruby/vim-ruby'
Bundle 'scrooloose/nerdtree'
Bundle 'moll/vim-node'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
" Bundle 'marijnh/tern_for_vim'
Bundle 'tmhedberg/matchit'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'
Bundle 'pangloss/vim-javascript'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-surround'
Bundle 'mustache/vim-mustache-handlebars'
Bundle 'lukaszb/vim-web-indent'
Bundle 'Valloric/MatchTagAlways'
Bundle 'tmhedberg/matchit'
Bundle 'ryyppy/nerdcommenter'
Bundle 'groenewege/vim-less'
Bundle 'duff/vim-bufonly'
Bundle 'mxw/vim-jsx' 
Bundle 'bling/vim-airline'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lambdatoast/elm.vim'
Bundle 'facebook/vim-flow'
Bundle 'mephux/bro.vim'

" YouCompleteMe 
if has('python')
    if v:version >= '704' 
        Bundle 'Valloric/YouCompleteMe'
        "Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
    endif
endif

set encoding=utf-8
set noet ai cin bs=2 cb=unnamed
set number ruler nowrap autoread showcmd showmode fdm=marker

" Disable the creation of backup files (those with ~)
set nobackup nowritebackup

" Fix the tabbing system
set tabstop=2 shiftwidth=2 expandtab
set autoindent smartindent nocindent indentexpr=
set hlsearch
set splitright

" Tabbing for specific filetypes
au FileType coffee setl sw=2 sts=2 et


" Specific tabbing for languages
autocmd Filetype javascript set tabstop=2 shiftwidth=2 expandtab

"Enable the neat filetype and syntax sugar
filetype on
filetype plugin on
filetype plugin indent on
syntax on

" Enable javascript highlighting for flowtype
au BufNewFile,BufRead *.flow set filetype=javascript

" Powerline
set laststatus=2
set noshowmode

"Set color scheme
set background=dark
"let g:solarized_termcolors=256
"colorscheme solarized
colorscheme grb256
set t_Co=256

" Keymappings
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Opening and closing braces
imap <C-F> {<CR>}<C-O>O

" Git-Commit formatting
autocmd Filetype gitcommit setlocal wrap spell textwidth=72

" MD formatting
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd Filetype markdown setlocal wrap textwidth=80 

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
let g:syntastic_less_use_less_lint = 0   

" You Complete Me Configuration
let g:ycm_autoclose_preview_window_after_completion=1

"if executable('jshint')
    "let g:syntastic_javascript_checkers=['jshint']
"endif
"
if executable('eslint')
    let g:syntastic_javascript_checkers=['eslint']
endif

" Flowtype config
let g:flow#autoclose = 1
