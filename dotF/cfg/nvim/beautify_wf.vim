" [[---------------------------------------Theme Settings    主题设置
source ~/dotF/cfg/nvim/lucius.vim
set background=light

if !exists('g:vscode')
    colorscheme lucius
    LuciusLight
endif

" if &diff
    " hi DiffAdd    guifg=#003300 guibg=#DDFFDD gui=none
    " hi DiffChange guibg=#ececec gui=none
    " hi DiffText   guifg=#000033 guibg=#DDDDFF gui=none
" endif

autocmd BufWritePost * if &diff == 1 | diffupdate | endif

set cursorline
" 很浅的绿色
hi CursorLine guibg=#e3efe3
" hi Cursor guibg=#0000cc  " 似乎被mobaxterm控制着

" 古老：For terminal Vim, with colors, we're most interested in the cterm
set termguicolors  " true (24-bit) colours. 下面改颜色只用改 guibg guifg
" 放文件前部分不行
hi Search guibg=#afafef guifg=#00aeae  

" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  " 被下面的代替了
" mobaxterm里insert mode还是方块。vscode里是正常的
set guicursor=n-v-c:block,
            \i-ci-ve:ver25,
            \r-cr:hor20,
            \o:hor50
            \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
            \,sm:block-blinkwait175-blinkoff150-blinkon175

syntax enable


highlight OperatorSandwichBuns guifg='#aa91a0' gui=underline 
highlight OperatorSandwichChange guifg='#edc41f' gui=underline 
highlight OperatorSandwichAdd guibg='#b1fa87' gui=none 
highlight OperatorSandwichDelete guibg='#cf5963' gui=none 


" 防止tmux下vim的背景色显示异常
if &term =~ '256color'
" http://sunaku.github.io/vim-256color-bce.html
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
    set t_ut=
endif


" Todo
" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(todo\|FIXME\|CHANGED\|DONE\|Todo\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
endif


" 不加bold时，背景前景会 对调
hi StatusLine     gui=bold guibg=#a4e4e4 guifg=#004040
hi StatusLineNC   gui=bold guibg=#e0f0f0 guifg=#0099a0


" 每行超过 n 个字的时候 , vim 自动加上换行符
set textwidth=100


highlight Search guibg='#dffefa' gui=none 


" hi User0 guifg=#ffffff  guibg=#094afe
hi User0 guifg=#000000  guibg=#00ffff
" hi User1 guifg=#ffdad8  guibg=#880c0e
" hi User2 guifg=#000000  guibg=#F4905C
" hi User3 guifg=#292b00  guibg=#f4f597
" hi User4 guifg=#112605  guibg=#aefe7B
" hi User5 guifg=#051d00  guibg=#7dcc7d
" hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
" hi User8 guifg=#ffffff  guibg=#5b7fbb
" hi User9 guifg=#ffffff  guibg=#810085

