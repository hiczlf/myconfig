"
"                       __   _(_)_ __ ___  _ __ ___
"                       \ \ / / | '_ ` _ \| '__/ __|
"                        \ V /| | | | | | | | | (__
"                       (_)_/ |_|_| |_| |_|_|  \___|
"
"作者 lf 
"邮箱 lifenglifeng001@gmail.com 
"备用邮箱 646101029@qq.com

set nocompatible "不兼容vi
let mapleader=","
let maplocalleader='\'
let g:mapleader=","
set shell=/bin/bash

"安装vundle和插件 {{{ ====================================
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"标签管理
Bundle 'L9'

" Color scheme
Bundle 'cschlueter/vim-mustang'
Bundle 'godlygeek/csapprox'

" Utilities
Bundle 'Raimondi/delimitMate'


" HTML Development
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" Universal Syntax Checker + Completion
Bundle 'scrooloose/syntastic'

" Python Syntax Checker
Bundle 'tpope/vim-pathogen'
Bundle 'hynek/vim-python-pep8-indent'

" Versioning System
Bundle 'tpope/vim-fugitive'

" YouCompleteMe 自动补全
Bundle 'Valloric/YouCompleteMe'


" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif


filetype plugin indent on " required!


" }}}

" 文件编辑 {{{ =================================="

" 设置<leader>为逗号


" 不匹配以下格式的文件
set wildignore=*.swp,*.bak,*.pyc,*.class  

"快速保存文件 
nnoremap <leader>w :w!<cr>

"快速编辑 .vimrc
nnoremap <leader>se :tabe $MYVIMRC<cr>
nnoremap <leader>sc :source $MYVIMRC<cr>

" 设定自动保存文件
set autowrite 

" 当vimrc更改, 重新加载
autocmd! bufwritepost vimrc source $MYVIMRC

" 更改字符串大小写
inoremap <c-c> <esc>bviw~ea
nnoremap <leader>c viw~

" 使用jk也可以退出insert mode
inoremap jk <esc>

"使用<C-v>粘贴
" inoremap <C-v> <ESC>:set paste<CR>"+gp<ESC>:set nopaste<ENTER>i<RIGHT>
"}}}

" tab和缩进设置 {{{ ====================

"设置tab为四个空格
set expandtab
set tabstop=4
set softtabstop=4

"设置自动缩进为4个空格
set shiftwidth=4

set smarttab

"断行时现实更加美观
set lbr

"行长度最长为160
set tw=160

set wrap "自动换行

"}}}

"  VIM 界面显示 {{{ ===============================

" 光标离顶部和底部至少3行
set scrolloff=5

" 总是显示当前位置
set ruler 

" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存 
set hid 

" 允许使用鼠标
set mouse=a

"可以删除一切东西
set backspace=eol,start,indent

" 允许移出当前行 
set whichwrap+=<,>,h,l

set magic 

"高亮显示对应的空格
set showmatch

" 尽量使用最少的列显示行号
set numberwidth=1 
se nu


set title " show title in console title bar
set wildmenu " Menu completion in command mode on <Tab>
set cursorline "高亮显示光标所在行
set colorcolumn=80 " Mark 80th column with a color line

" Set default environment based on current edited files
autocmd BufEnter * silent! lcd %:p:h

" Always show status line, even for one window
set laststatus=2

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd
" }}}

" 颜色和字体 {{{ =============================================

syntax enable  "使用语法高亮

set t_Co=256 "256色
set guioptions-=T

set background=dark
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme mustang
set gfn=Liberation\ Mono\ 10 "设置字体

set encoding=utf8

" Search and error color highlights
hi Search guifg=#ffffff guibg=#0000ff gui=none ctermfg=white ctermbg=darkblue
hi IncSearch guifg=#ffffff guibg=#8888ff gui=none ctermfg=white
highlight SpellBad guifg=#ffffff guibg=#8888ff gui=none ctermfg=black ctermbg=darkred

" }}}

" 版本控制 {{{ =================

" 关闭自动备份， 因为会使用git备份
set nobackup
set nowb
set noswapfile

" }}}

" 搜索，移动， 标签，缓冲 {{{ ============================
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"应对行很长的情况
noremap j gj
noremap k gk

"取消搜索时的高亮
noremap <silent> <leader><cr> :nohlsearch<cr>


"--- search options ------------
set incsearch " show 'best match so far' as you type
set hlsearch " hilight the items found by the search
set ignorecase " ignores case of letters on searches
set smartcase " Override the 'ignorecase' option if the search pattern contains upper case characters

" page down with <SPACE>, pageup with - or <BkSpc>
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" }}}

"
" 编程相关 {{{ ====================================


" Shortcut to Close quickfix window with leader+q
nnoremap <leader>q <CR>:cclose<CR>

" markdown
au BufEnter,Bufread *.mkd,*.md,*.mdown,*.markdown set tw=0

" http://www.brankovukelic.com/post/2091037293/turn-vim-into-powerful-javascript-editor"

" HTML (tab width 2 chr, no wrapping)
autocmd FileType html set sw=2
autocmd FileType html set ts=2
autocmd FileType html set sts=2
autocmd FileType html set textwidth=0

" XHTML (tab width 2 chr, no wrapping)
autocmd FileType xhtml set sw=2
autocmd FileType xhtml set ts=2
autocmd FileType xhtml set sts=2
autocmd FileType xhtml set textwidth=0

" CSS (tab width 2 chr, wrap at 79th char)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2

" javascript 
autocmd FileType javascript set shiftwidth=4
autocmd FileType javascript set ts=4
autocmd FileType javascript set sts=4
autocmd FileType javascript set textwidth=79

" python
autocmd FileType python setlocal foldmethod=indent nosmartindent shiftwidth=4 ts=4 et cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd bufnewfile *.py so ~/.vim_template/python_header.txt


" Folding
" auto save folding : http://princ3.wordpress.com/2007/01/26/automaticaly-save-foldings-in-vim/
set viewoptions=folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

autocmd Syntax c,cpp,vim,xml,html,xhtml,js,php set foldmethod=manual
autocmd Syntax python,py set foldmethod=indent
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

"remove trailing whitespace
"http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
autocmd BufWritePre *.c :%s/\s\+$//e
autocmd BufWritePre *.cpp :%s/\s\+$//e
autocmd BufWritePre *.c++ :%s/\s\+$//e
autocmd BufWritePre *.h :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e
autocmd BufWritePre *.php :%s/\s\+$//e
autocmd BufWritePre *.pl :%s/\s\+$//e
autocmd BufWritePre *.py :%s/\s\+$//e

" tabs, not spaces for php, ctp
au BufEnter,BufRead *.php,*.ctp set noexpandtab

" Autoclose quickfix windows when quit
" http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
if has("gui_running")
" Vimdiff colorscheme
    highlight DiffAdd cterm=none ctermfg=bg ctermbg=Green gui=none guifg=bg guibg=Green
    highlight DiffDelete cterm=none ctermfg=bg ctermbg=Red gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=none ctermfg=bg ctermbg=Yellow gui=none guifg=bg guibg=Yellow
    highlight DiffText cterm=none ctermfg=bg ctermbg=Magenta gui=none guifg=bg guibg=Magenta
endif


" 插件设置 {{{ ================================================


"}}}

" 格式检查 {{{ ===========

let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args="--ignore=E501,E126,E128,E401,E302"

let g:syntastic_mode_map = {'passive_filetypes': ['rst']}
let g:syntastic_always_populate_loc_list = 1

nnoremap <leader>p :lprev<CR>
nnoremap <leader>n :lnext<CR>

"}}}

" 自动补全 {{{ ===========

let g:ycm_global_ycm_extra_conf = ''
let g:ycm_autoclose_preview_window_after_completion=1
" 解决youcompleteme server崩溃问题
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_always_populate_location_list = 1
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"}}}

" vim:foldmethod=marker
