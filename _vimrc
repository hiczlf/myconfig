"
"                       __   _(_)_ __ ___  _ __ ___
"                       \ \ / / | '_ ` _ \| '__/ __|
"                        \ V /| | | | | | | | | (__
"                       (_)_/ |_|_| |_| |_|_|  \___|
"

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
call vundle#begin()


" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

"测试自己的plugin
Plugin 'lifenglifeng001/lfgrep'

"标签管理
Plugin 'L9'

" Color scheme
Plugin 'cschlueter/vim-mustang'
Plugin 'godlygeek/csapprox'

" Utilities
Plugin 'Raimondi/delimitMate'


" HTML Development
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Universal Syntax Checker + Completion
Plugin 'scrooloose/syntastic'

" Python Syntax Checker
Plugin 'hynek/vim-python-pep8-indent'

" Versioning System
Plugin 'tpope/vim-fugitive'

" YouCompleteMe 自动补全
Plugin 'Valloric/YouCompleteMe'

" 多行注释
Plugin 'scrooloose/nerdcommenter'

"Nerdtree
Plugin 'scrooloose/nerdtree'


" Installing plugins the first time
if iCanHazVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

call vundle#end()

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
inoremap <c-t> <esc>bviw~ea
nnoremap <leader>t viw~

" 使用jk也可以退出insert mode
inoremap jk <esc>


" 防止vim退出清空剪切板
autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")


" tab相关设置
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab

"断行时现实更加美观
set lbr

"行长度最长为160
set tw=160

set wrap "自动换行

" 执行当前脚本

nnoremap <leader>r :w<CR>:!%:p 


" 显示目录树
map <C-n> :NERDTreeToggle<CR>

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

" 搜索字符串里面只有小写时, 忽略大小写, 若有大写, 则不忽略大小写
set ignorecase smartcase 

" page down with <SPACE>, pageup with - or <BkSpc>
noremap <Space> <PageDown>
noremap <BS> <PageUp>

" }}}

" 编程相关 {{{ ====================================


" markdown
au BufEnter,Bufread *.mkd,*.md,*.mdown,*.markdown set filetype=markdown


" html 和 xhtml
augroup html_syntax
    autocmd!
    autocmd FileType html,xhtml set shiftwidth=2
    autocmd FileType html,xhtml set tabstop=2
    autocmd FileType html,xhtml set softtabstop=2
    autocmd FileType html,xhtml set textwidth=0
augroup END

" CSS 
augroup css_syntax
    autocmd!
    autocmd FileType css set shiftwidth=2
    autocmd FileType css set tabstop=2
    autocmd FileType css set softtabstop=2
    autocmd FileType javascript set textwidth=79
augroup END

" javascript 
augroup javascript_syntax
    autocmd!
    autocmd FileType javascript set shiftwidth=4
    autocmd FileType javascript set tabstop=4
    autocmd FileType javascript set softtabstop=4
    autocmd FileType javascript set textwidth=79
augroup END

" python
augroup python_syntax
    autocmd!
    autocmd FileType python setlocal shiftwidth=4 tabstop=4
    " 导入python模板文件
    autocmd BufNewFile *.py so ~/.vim_template/python_header.txt
augroup END

" shell
augroup shell_syntax
    autocmd!
    autocmd BufNewFile *.sh so ~/.vim_template/shell_header.txt
    autocmd BufWritePre *.sh  setlocal autoread
    autocmd BufWritePost *.sh silent !chmod +x <afile> 
augroup END


" 保存缩进和鼠标位置
" augroup save_view
"     autocmd!
"     setlocal viewoptions=cursor,folds
"     au BufWinLeave * silent! mkview
"     au BufWinEnter * silent! loadview
" augroup END

" 缩进
augroup fold_method
    autocmd!
    autocmd Syntax cpp,xml,html,xhtml,js,php set foldmethod=manual
    autocmd FileType python setlocal foldmethod=indent nosmartindent 
    autocmd FileType c setlocal foldmethod=syntax
    autocmd Syntax vim setlocal foldmethod=marker
    autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
augroup END

" 保存时删除行末尾的空格
augroup remove_space_EOL
    autocmd!
    autocmd BufWritePre *.py :%s/\s\+$//e
    autocmd BufWritePre *.c :%s/\s\+$//e
    autocmd BufWritePre *.cpp :%s/\s\+$//e
    autocmd BufWritePre *.c++ :%s/\s\+$//e
    autocmd BufWritePre *.h :%s/\s\+$//e
    autocmd BufWritePre *.java :%s/\s\+$//e
    autocmd BufWritePre *.php :%s/\s\+$//e
    autocmd BufWritePre *.pl :%s/\s\+$//e
augroup END


" 退出时自动关闭quickfix
" http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
augroup QFClose
  autocmd!
  autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""'
if has("gui_running")
" Vimdiff colorscheme
    highlight DiffAdd cterm=none ctermfg=bg ctermbg=Green gui=none guifg=bg guibg=Green
    highlight DiffDelete cterm=none ctermfg=bg ctermbg=Red gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=none ctermfg=bg ctermbg=Yellow gui=none guifg=bg guibg=Yellow
    highlight DiffText cterm=none ctermfg=bg ctermbg=Magenta gui=none guifg=bg guibg=Magenta
endif

"}}}


" 插件设置 {{{ ================================================
" 注释分隔符号后添加空格
let g:NERDSpaceDelims = 1

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

" let g:ycm_global_ycm_extra_conf = ''
let g:ycm_autoclose_preview_window_after_completion=1

" 解决youcompleteme server崩溃问题
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_always_populate_location_list = 1
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" 不再提示是否加载ycm_extra_conf.py
let g:ycm_confirm_extra_conf = 0

"}}}

