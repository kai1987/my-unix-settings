set history=50   " keep 50 lines of command line history
set showcmd   " display incomplete commands
set showmode  " display the current editing mode

" get rid of the F1 help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
\ | wincmd p | diffthis

set guioptions-=T

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码
set encoding=utf-8
" set fileencodings=utf-8,chinese,latin-1
set fileencodings=utf-8
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif
" language message zh_CN.utf-8
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"set font
"set guifont=Nsimsun

set nocompatible  " 不要使用vi的键盘模式，而是vim自己的

set confirm " 在处理未保存或只读文件的时候，弹出确认

filetype on  " 侦测文件类型

filetype plugin on  " 载入文件类型插件

filetype indent on  " 为特定文件类型载入相关缩进文件

set iskeyword+=_,$,@,%,#,- " 带有如下符号的单词不要被换行分割

syntax on  " 语法高亮

highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不要备份文件（根据自己需要取舍）
set nobackup

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
setlocal noswapfile
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" 在状态行上显示光标所在位置的行号和列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 不让vim发出讨厌的滴滴声
set noerrorbells

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索和匹配
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The first two lines fix Vim’s horribly broken default regex “handling” by automatically inserting a \v before any string you search for.
nnoremap / /\v
vnoremap / /\v
set ignorecase " 在搜索的时候忽略大小写
set smartcase  "If you search for an all-lowercase string your search will be case-insensitive, but if one or more characters is uppercase the search will be case-sensitive.
set gdefault   "applies substitutions globally on lines. For example, instead of :%s/foo/bar/g you just type :%s/foo/bar/.
set incsearch " 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set showmatch " 高亮显示匹配的括号
set matchtime=5 " 匹配括号高亮的时间（单位是十分之一秒）
set hlsearch " 高亮被搜索的句子（phrases）

" makes it easy to clear out a search by typing ,<space>. This gets rid of the distracting highlighting once I’ve found what I’m looking for.
nnoremap <leader><space> :noh<cr>

" make the tab key match bracket pairs. I use this to move around all the time and <tab> is a hell of a lot easier to type than %.
nnoremap <tab> %
vnoremap <tab> %

" 输入:set list命令是应该显示些啥？
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" 不要闪烁
set novisualbell

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" 总是显示状态行
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动格式化
set formatoptions=tcrqn

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

" 使用C样式的缩进
set cindent
"set cinkeys=0{,0},:,0#,!,!^F

" 制表符为2
set tabstop=2

" 统一缩进为2
set softtabstop=2
set shiftwidth=2

" 不要用空格代替制表符
set expandtab

" 不要换行
set nowrap

" 在行和段开始处使用制表符
set smarttab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" working with split window
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This next set of mappings maps <C-[h/j/k/l]> to the commands needed to move
" around your splits. If you remap your capslock key to Ctrl it makes for very
" easy navigation.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ,w open a new vertical split and switch over to it.
nnoremap <leader>w <C-w>v<C-w>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number

let mapleader = "\\"  " use \ as the lead key

"设置tab操作的快捷键，绑定:tabnew到<leader>t，绑定:tabn, :tabp到<leader>n,
"<leader>p
map <leader>t :tabnew<CR>
map <leader>n :tabn<CR>
map <leader>p :tabp<CR>

"使用<leader>e打开当前文件同目录中的文件
"if has("unix")
"map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
"else
"map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
"endif

" 用空格键来开关折叠
set foldenable
set foldmethod=marker
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" remove all trailing spaces in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" 用f8作为tag bar 的快捷键
nmap <F1> :TagbarToggle<CR>
nmap <F5> :NERDTreeToggle<CR>

au FocusLost * :wa "save on losing focus

" I have a ,v mapping to reselect the text that was just pasted so I can
" perform commands (like indentation) on it:
nnoremap <leader>v V`]

" quickly open up my ~/.vimrc file in a vertically split window so I can add new things to it on the fly.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" I personally use jj to exit back to normal mode.
inoremap jj <ESC>

" use Ctrl + Space for auto complition
inoremap <C-Space> <C-n>

autocmd BufWritePre * :%s/\s\+$//e

"let g:tagbar_ctags_bin = '/usr/local/bin/ctags'


if &term =~ "xterm"
  "256 color --
  let &t_Co=256
  " restore screen after quitting
  set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
  if has("terminfo")
    let &t_Sf="\ESC[3%p1%dm"
    let &t_Sb="\ESC[4%p1%dm"
  else
    let &t_Sf="\ESC[3%dm"
    let &t_Sb="\ESC[4%dm"
  endif
endif


" colo Clouds Midnight
" colo clouds_midnight
" colo Mustang_Vim_Colorscheme_by_hcalves
colo pablo

" add coffee tagbar support: https://github.com/lukaszkorecki/coffeetags
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

"To enable auto-popup for this completion, add following function to plugin/snipMate.vim:
let g:acp_behaviorSnipmateLength = 1

