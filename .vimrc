"""""""""""""""""""""""""""""""""""""""""""""""""
"
"           filename: .vimrc
"
"""""""""""""""""""""""""""""""""""""""""""""""""

"
"
"================================================
"           vim 基本设置
"================================================
"
"
set  nocompatible		"不使用 vi 的键盘模式，使用 vim 自己的
filetype on				"侦测文件类型
filetype plugin on		"载入文件类型插件
filetype indent on		"为特定文件类型载入相关缩进文件
set completeopt=longest,menu	"智能补全
colorscheme desert		"背景主题设置
syntax enable			"设置语法高亮
syntax on
set number				"设置显示行号
set history=1000		"历史记录数
set noeb				"去掉输入错误提示音
set confirm				"处理未保存或只读文件时，弹出确认
set tabstop=4			"保存一个 tab 是4个字符
set autoindent			"自动缩进
set cindent
set softtabstop=4		"按一次tab前进4个字符
set shiftwidth=4		"写代码时用到，缩进4个字符
set noexpandtab			"不使用空格代替制表符
set nobackup			"禁止生成备份文件
set noswapfile			"禁止生成临时文件
set ignorecase			"搜索忽略大小写
set showmatch			"高亮显示匹配的括号
set matchtime=1			"匹配括号高亮的时间（单位是十分之一秒）
set smartindent			"为C程序提供自动缩进
set hlsearch			"搜索逐字符高亮
set incsearch
set expandtab			"将 tab 键转换为空格
set foldenable			"允许折叠
set foldmethod=manual	"手动折叠
set showcmd				"显示命令
set cmdheight=1			"命令行的高度
"set whichwrap+=<,>,h,l	"允许backspace和光标键跨行边界
"set scrolloff=3 		"光标移动到buffer的顶部和底部时保持3行距离
"set novisualbell		"不要闪烁
"set laststatus=1		"启动显示状态行(1),总是显示状态行(2)

au BufRead,BufNewFile *  setfiletype txt	" 高亮显示普通txt文件（需要txt.vim脚本）
"""""""""""""""""""""""""""""""""""""""""""""""""
"自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""
"显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
"
"
"================================================
" 键盘命令
"================================================
"
"
nnoremap <F2> :g/^\s*$/d<CR>	"去空行
nnoremap <C-F2> :vert diffsplit	"比较文件
"""""""""""""""""""""""""""""""""""""""""""""""""
"C、C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == "c"
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == "cpp"
		exec "!gcc % -o %<"
		exec "! ./%<"
	elseif &filetype == "sh"
		exec "! ./%"
	endif
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""
"C、C++ 按F8调试
map <F8> :call RunGdb()<CR>
func! RunGdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc

"
"
"================================================
" 新文件标题
"================================================
"
"
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
func SetTitle()
	if &filetype == 'sh'
        call setline(1, "\#################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: xx00")
        call append(line(".")+2, "\# Mail: 673305029@qq.com"))
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#################################################")

        call append(line(".") + 5, "\#!/bin/bash")
        call append(line(".") + 6, "")
    else
        call setline(1, "/**************************************************")
        call append(line("."), " > File Name: ".expand("%"))
        call append(line(".")+1, " > Author: xx00")
        call append(line(".")+2, " > Mail: 673305029@qq.com"))
        call append(line(".")+3, " > Created Time: ".strftime("%c"))
        call append(line(".")+4, " **************************************************/")

        call append(line(".")+5, "")
    endif
    if &filetype == "cpp"
        call append("." + 6, "#include <iostream>")
        call append("." + 7, "using namespace std")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append("." + 6, "#include <stdio.h>")
        call append(line(".") + 7, "")
    endif

    "autocmd BufNewFile * normal G
endfunc

"
"
"================================================
" Vundle插件管理器配置
"================================================
"
"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"
" vim-scripts repos
Bundle 'gmarik/vundle'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'bufexplorer.zip'
Bundle 'taglist.vim'
Bundle 'Mark'
Bundle 'The-NERD-tree'
Bundle 'matrix.vim'
Bundle 'closetag.vim'
Bundle 'The-NERD-Commenter'
Bundle 'matchit.zip'
Bundle 'AutoComplPop'
Bundle 'jsbeautify'
Bundle 'YankRing.vim'
Bundle 'winmanager'

" original repos on github
Bundle 'klen/Python-mode'
Bundle 'scrooloose/syntastic'

" non github repos
"example: Bundle 'git://git.wincent.com/command-t.git'


let Tlist_Show_One_File=1
set tags=tags
set autochdir
let Tlist_WinWidth=40
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Left_Window=1

let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplMapWindowNavVim=1
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplModSelTarget=1
let g:miniBufExplMoreThanOne=0

let g:winManagerWindowLayout='FileExplorer|TagList'
" 快捷键
nmap wm :WMToggle<cr>
nmap <leader>e :NERDTree<CR>


source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
