" 设置文件编码

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,chinese,latin1
" 映射 --- {{{
let mapleader=","
let maplocalleader="\\"

" map
" 编辑vimrc 文件
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" 执行vimrc 文件
nnoremap <leader>sv :source $MYVIMRC<cr>
" 取消搜索高亮
noremap <silent> <leader><cr> :nohlsearch<cr>
" 使用jk退出编辑模式
inoremap jk <esc>

" ubuntu 下面系统解决版寄存器时+， 使用*映射
vnoremap "*y "+y
nnoremap "*p "+p
nnoremap "*P "+P

" }}}

" 插件 --- {{{
set nocompatible              " 不兼容vi
filetype off                  " required
" set the runtime path to include Vundle and initialize


" 设置运行路径和vundle路径
if has("win32")
    set rtp+=$USERPROFILE/vimfiles/bundle/Vundle.vim/
	call vundle#begin('$USERPROFILE/vimfiles/bundle/')
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif 

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 样式
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'

" 文件浏览
Plugin 'scrooloose/nerdtree'

" 格式检查
Plugin 'scrooloose/syntastic'

" 自动补全
Plugin 'davidhalter/jedi-vim'

" 多行注释
Plugin 'scrooloose/nerdcommenter'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"}}}

" 插件设置 --- {{{

"  ------ NERDTree
" 自动打开文件浏览当gvim没有选择文件打开时
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 打开关闭nerdtree 
map <leader>n :NERDTreeToggle<CR>

" }}}

" 编辑 --- {{{
" 自动缩进
filetype indent on

" 设置删除键在所有模式生效
set backspace=indent,eol,start

" 设置tab为四个空格
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
" }}}

" 显示  --- {{{

" 搜索高亮显示
set hlsearch incsearch

" 状态栏
set laststatus=2     " 一直显示状态
set statusline=%f    " 显示相对路径
set statusline+=%=   " 切换到右边
set statusline+=%l   " 当前行号
set statusline+=/    " 分隔符
set statusline+=%L   " 总行号

" 光标离顶部和底部至少3行
set scrolloff=5

" 总是显示当前位置
set ruler

set title " 显示标题
set wildmenu " 支持命令行自动补全
set cursorline "高亮显示光标所在行
set colorcolumn=80 " Mark 80th column with a color line

" 颜色
syntax enable        " 语法高亮
if has("gui_running")
    set background=dark
	colorscheme solarized
else
    colorscheme molokai
    let g:rehash256 = 1 " 尽量使用256颜色
endif 

" 字体
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" 显示行号
set number

" 打开文件不默认缩进
set foldlevel=99

" }}}

" 编程相关 {{{ ====================================

" 代码折叠
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" markdown
au BufEnter,Bufread *.mkd,*.md,*.mdown,*.markdown set filetype=markdown

augroup yaml_syntax
    autocmd!
    autocmd FileType yaml set shiftwidth=2
    autocmd FileType yaml set tabstop=2
    autocmd FileType yaml set softtabstop=2
    autocmd FileType yaml set textwidth=0
augroup END


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
	set foldmethod=indent   
	autocmd FileType python setlocal shiftwidth=4 tabstop=4
augroup END

" shell
augroup shell_syntax
    autocmd!
    autocmd BufWritePre *.sh  setlocal autoread
    autocmd BufWritePost *.sh silent !chmod +x <afile> 
augroup END

" 格式检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']

nnoremap <silent> <F5> :SyntasticCheck<CR>  
nnoremap <leader>ln :lnext<CR>  
nnoremap <leader>lp :lprevious<CR>  
nnoremap <leader>lc :lclose<CR>  

" 语法提示
let g:jedi#goto_command = "<leader>jd"
let g:jedi#goto_assignments_command = "<leader>jg"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>jn"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>jr"

" 关闭自动补全
let g:jedi#completions_enabled = 0

"}}}

" 测试 --- {{{
" }}} 
