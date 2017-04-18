"语法高亮
syntax on
"如果此时语法还是没有高亮显示，那么在/etc目录下的profile文件中添加以下语句：
"export TERM=xterm-color

"不讨论制表符为8还是为4较好，这里设置（软）制表符宽度为4：
set tabstop=4
set softtabstop=4

"设置缩进的空格数为4
set shiftwidth=4

"设置自动缩进：即每行的缩进值与上一行相等；使用 noautoindent 取消设置：
set autoindent
"设置使用 C/C++ 语言的自动缩进方式：
set cindent
"autoindent 就是自动缩进的意思，当你在输入状态用回车键插入一个新行，或者在 normal 状态用 o 或者 O 插入一个新行时，autoindent会自动地将当前行的缩进拷贝到新行，也就是"自动对齐”，当然了，如果你在新行没有输入任何字符，那么这个缩进将自动删除。cindent 就不同了，它会按照 C 语言的语法，自动地调整缩进的长度，比如，当你输入了半条语句然后回车时，缩进会自动增加一个 TABSTOP 值，当你键入了一个右花括号时，会自动减少一个 TABSTOP 值。

set ai "或者 set autoindent vim使用自动对齐，也就是把当前行的对齐格式应用到下一行 
set si "或者 set smartindent 依据上面的对齐格式，智能的选择对齐方式 

"设置C/C++语言的具体缩进方式（以我的windows风格为例）：
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s

"如果想在左侧显示文本的行号，可以用以下语句：
set nu

"最后，如果没有下列语句，就加上吧：
if &term=="xterm"
	set t_Co=8
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif

set fenc=utf-8 "设定默认解码 
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936 

set nocp "或者 set nocompatible 用于关闭VI的兼容模式 
set ruler "设置在编辑过程中,于右下角显示光标位置的状态行 
set incsearch "设置增量搜索,这样的查询比较smart 
set showmatch "高亮显示匹配的括号 
set matchtime=5 "匹配括号高亮时间(单位为 1/10 s) 
set ignorecase "在搜索的时候忽略大小写 

"智能补全 
filetype plugin on
filetype indent on

"graphviz filetype detect
fun! s:DetectGraphviz()
	if getline(1) == 'digraph'
		set filetype=dot
	endif
endfun

au BufRead,BufNewFile *.gv,*.dot set filetype=dot
au BufRead,BufNewFile * call s:DetectGraphviz()
"graphviz end

set completeopt=longest,menu
"let mapleader = ""  
imap <TAB> <C-X><C-O>
hi Normal ctermbg=black ctermfg=white

"颜色设置 guifg前景色，guibg背景色。（注：guifg、guibg是用在gvim下，而控制台vim则是用ctermbg、ctermfg）
set background=dark
set hls
hi Normal ctermbg=Black ctermfg=white   "设置编辑区的显示颜色
"hi Normal guibg=#99cc99 guifg=Black  
hi LineNr guibg=#003366 guifg=#99ccff ctermbg=7777 ctermfg=blue  "设置行号区的色彩
"设置当前行的色彩，即光标所在行。
set cursorline  
"hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=#66cc99 guifg=black  
hi StatusLine ctermfg=red ctermbg=Grey

"括号补全
function! AutoPair(open, close)
        let line = getline('.')
        if col('.') > strlen(line) || line[col('.') - 1] == ' '
                return a:open.a:close."\<ESC>i"
        else
                return a:open
        endif
endf

function! ClosePair(char)
        if getline('.')[col('.') - 1] == a:char
                return "\<Right>"
        else
                return a:char
        endif
endf

function! SamePair(char)
        let line = getline('.')
        if col('.') > strlen(line) || line[col('.') - 1] == ' '
                return a:char.a:char."\<ESC>i"
        elseif line[col('.') - 1] == a:char
                return "\<Right>"
        else
                return a:char
        endif
endf

inoremap ( <c-r>=AutoPair('(', ')')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=AutoPair('{', '}')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=AutoPair('[', ']')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap " <c-r>=SamePair('"')<CR>
inoremap ' <c-r>=SamePair("'")<CR>
inoremap ` <c-r>=SamePair('`')<CR>
"括号补全结束
"noremap是不会递归的映射 (大概是no recursion)
"例如noremap Y y
"noremap y Y
"不会出现问题
"前缀代表生效范围
"inoremap就只在插入(insert)模式下生效
"vnoremap只在visual模式下生效
"nnoremap就在normal模式下效
"这样可以减少快捷键所用到的键位组合的个数


" set the runtime path to include Vundle and initialize
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'
" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
"Plugin 'tpope/vim-fugitive'
"Plugin 'https://github.com/scrooloose/nerdtree.git'
filetype plugin indent on     " required
Bundle 'Valloric/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'


"--fold setting--
set foldmethod=syntax " 用语法高亮来定义折叠
set foldlevel=100 " 启动vim时不要自动折叠代码
set foldcolumn=5 " 设置折叠栏宽度

"常用命令
"za  打开/关闭在光标下的折叠
"zA  循环地打开/关闭光标下的折叠
"zo  打开 (open) 在光标下的折叠
"zO  循环打开 (Open) 光标下的折叠
"zc  关闭 (close) 在光标下的折叠
"zC  循环关闭 (Close) 在光标下的所有折叠
"zM  关闭所有折叠
"zR  打开所有的折叠

"quit
noremap <C-x> <Esc>:q<CR>
"save and quit
noremap <C-c> <Esc>:wq<CR>

"Show Type
noremap <F1> <Esc>:YcmCompleter GetType<CR>
"Goto definition or declaration
noremap <F2> <Esc>:YcmCompleter GoToDefinitionElseDeclaration<CR>
"switch .c/.h
noremap <F4> <Esc>:A<CR>

"NerdTree
let NERDTreeWinPos=1
noremap <F9> <Esc>:NERDTreeToggle<CR>
