set showcmd   " display incomplete commands
set showmode  " display the current editing mode
"set cursorcolumn "  高亮当前光标所在列
set cursorline "  高亮当前光标所在行
"hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=NONE guifg=NONE


" get rid of the F1 help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Don't use Ex mode, use Q for formatting
map Q gq

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
\ | wincmd p | diffthis
\ | wincmd p | diffthis

" I use the following (Uses Consolas size 11 on Windows,
" Menlo Regular size 14 on Mac OS X and Inconsolata size 12 everywhere else):
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=YaHei\ Consolas\ Hybrid:h14
    "set guifont=Consolas:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim 包管理器 VBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible  " 不要使用vi的键盘模式，而是vim自己的
set confirm " 在处理未保存或只读文件的时候，弹出确认
filetype off                  " required

" filetype on  " 侦测文件类型

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" 以下开始安装各种插件
" http://vim-scripts.org/vim/scripts.html

Plugin 'tpope/vim-fugitive'   " 在 vim 中直接使用 git 指令。 https://github.com/tpope/vim-fugitive
Plugin 'The-NERD-tree'   " file explorer
" Plugin 'snipMate'  " TextMate-style snippets for Vim
Plugin 'yi/snipmate.vim'  " TextMate-style snippets for Vim
Plugin 'Tagbar'  " Display tags of the current file ordered by scope
Plugin 'The-NERD-Commenter'  " A plugin that allows for easy commenting of code for many filetypes.
"Plugin 'Shougo/neocomplcache.vim'  " Ultimate auto-completion system for Vim
Plugin 'AutoComplPop'  " Automatically opens popup menu for completions
Plugin 'kchmck/vim-coffee-script'  " CoffeeScript support for vim
Plugin 'leafo/moonscript-vim'  " Adds syntax highlighting and indent support for MoonScript in vim.
Plugin 'jade.vim'  " Vim Jade template engine syntax highlighting and indention
Plugin 'xolox/vim-misc'  " required by lua.vim
Plugin 'yi/lua.vim'  " Lua file type plug-in for the Vim text editor
" turn on omni completion of lua.vim
let g:lua_complete_omni = 1

Plugin 'yi/QFixToggle'   " Toggle the visibility of the quickfix window
Plugin 'ctrlp.vim'   " Fuzzy file, buffer, MRU, and tag finder with regexp support.
Plugin 'Lokaltog/vim-powerline'   " The ultimate vim statusline utility.
Plugin 'plasticboy/vim-markdown'  "Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/
let g:vim_markdown_folding_disabled=1

Plugin 'elzr/vim-json'  " A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.


let g:snippets_dir="~/.vim/snippets/"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码
set encoding=utf-8


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
set number  " 显示行号

let mapleader = "\\"  " 把 \ 设定为 leader key,  use \ as the lead key

"设置tab操作的快捷键，绑定:tabnew到<leader>t，绑定:tabn, :tabp到<leader>n,
"<leader>p
map <leader>t :tabnew<CR>
map <leader>n :tabn<CR>
map <leader>p :tabp<CR>

" 用空格键来开关折叠
set nofoldenable
set foldmethod=marker
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" remove all trailing spaces in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" 用 F1 作为 nerd tree 的快捷键
nmap <F1> :NERDTreeToggle<CR>

" 用 F2 toggle quickfix window
nmap <F2> :QFix<CR>

" 用 F3 打开文件快速查找
nmap <F3> :CtrlP<CR>

" 用 F5 作为tag bar 的快捷键
nmap <F5> :TagbarToggle<CR>

" 按 F6 或者 \lc 执行 CoffeeLint
nmap <F6> :CoffeeLint<CR>:QFix<CR>
nnoremap <leader>lc :CoffeeLint<CR>:QFix<CR>


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

colo pablo

" add coffee tagbar support: https://github.com/lukaszkorecki/coffeetags
if executable('coffeetags')
    let g:tagbar_type_coffee = {
            \ 'ctagsbin' : 'coffeetags',
            \ 'ctagsargs' : '--include-vars',
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

" To enable auto-popup for this completion, add following function to plugin/snipMate.vim:
let g:acp_behaviorSnipmateLength = 1

" If non-zero, "preview" is added to 'completeopt' when auto-popup.
let g:acp_completeoptPreview = 1

