# Ctrl+S is normally STOP (freeze output to the terminal)
# and Ctrl+Q is normally START (unfreeze).
# You may not be able to change this value, because
# the hardware (现在常见的情况，其实是终端模拟器？) may insist on using C-Q regardless of what you specify.
# https://www.gnu.org/software/libc/manual/html_node/Start_002fStop-Characters.html

# To remove those special characters,
stty stop undef
stty start undef
# 有人这两个都设，那就照做吧
stty -ixon #  禁用 XON/XOFF flow control
stty -ixoff # 禁止 sending of start/stop characters
# stty ixoff is not related to CTRL-S and CTRL-Q

# 作用应该同上
# unsetopt flow_control  # 禁止接收 start/stop characters ？


# 记忆： s for source 原样输入
# type characters literally
# 敲ctrl backspace会显示^?, 而非退格
stty lnext "^s"  # 要  双引号括起来
# 这样会把pause/break显示为ctrl z
# 默认是ctrl v，但要用来paste啊
# only affects the terminal device line discipline internal editor (the very limited one you get when running applications like cat that don't have their own line editor

bindkey '^S' quoted-insert
bindkey '^_' push-line-or-edit
# bindkey '^u'   # tmux里设了
bindkey '^q' push-line-or-edit  # ctrl s能改，这行为啥不生效? 一直是删除整行
# =====================================================================<_<_<



bindkey -s '^[^?' 'echo "待用" \n'  # ASCII DEL == 0x7f == 0177 == ^?


# bindkey "^C" self-insert  # 原样输入

# 按2下ctrl，相当于敲了ctrl c，因为有道翻译取词翻译时，应该要悄悄复制

# 声明key这个变量是not local的,且是arrays
typeset -g -A key
# -g do not restrict parameter to local scope
# -A specify that arguments refer to associative arrays

# alt 负责路径跳转


# bindkey -s in-string out-string

bindkey -s '\eh' '~ \n'
# t太难按了
# bindkey -s '\et' '~/.l \n'
# w: wait: 要删除文件？wait， mv到垃圾箱吧
bindkey -s '\ew' '~/.t \n'

bindkey -s '\e3' '~/3 \n'
bindkey -s '\ed' '~/d \n'
# m for modify，修改配置
bindkey -s '\em' '~/dotF \n'
bindkey -s '\et' '~/.t \n'
bindkey -s '\ec' 'cfg \n'

# bindkey -s "\C-o" "cle \C-j"  # 很少用

bindkey -s "\C-o" "- \n"  # 和vim的体验一致
bindkey -s "\eo" "- \n"  #  alt负责路径切换
# bindkey -s "\C-b" "echo '待用' \n"

# 待绑定：
# C-f
# C-b
# C-d
# C-8
# C-g
# C-Space
bindkey -s "\C-g" "echo '待用' \n"
# bindkey -s "\C-m" "echo '待用' \n"  # 和回车键是一回事
bindkey -s "\C-t" "tt \C-j"  # python ~/d/tmp.py  # t for try


# bindkey -s "\C-q" "echo '待用' \n"  # 无法修改。作用一直是删除

# todo
# ^D在当前行 有字符时, 相当于Del
#            无字符是, 退出 (但无字符时, 按真正的Del, 不会退出)
#
# 没有unbind命令, 想unbind,可以把某个key, bind为不存在的function, 报错后删掉

# 来自zkbd, 根据你自己的电脑的情况设置, 比terminfo靠谱
# function keys (commonly at the top of a PC keyboard)
key[F1]='^[OP'
key[F2]='^[OQ'
key[F3]='^[OR'
key[F4]='^[OS'

# 亲测,确实如此. 为啥会突变?
key[F5]='^[[15~'
key[F6]='^[[17~'
key[F7]='^[[18~'
key[F8]=''''
key[F9]='^[[20~'
key[F10]='^[[21~'
key[F11]='^[[23~'
key[F12]='^[[24~'

key[Backspace]='^?'
key[Insert]='^[[2~'

key[Home]='^[[1~'
# 等价于:
# ^[[H
key[End]='^[[4~'
# 等价于:
# ^[[F

key[Delete]='^[[3~'

key[PageUp]='^[[5~'
key[PageDown]='^[[6~'

key[Up]='^[[A'
key[Down]='^[[B'
key[Right]='^[[C'
key[Left]='^[[D'
key[Menu]=''''


# 不再需要了:
# 系统的zshrc(就算我没source,开新的zsh时会自动source)里设置了:
# terminfo的东西是在application mode下的, 而zsh用的是raw mode, 所以自己指定吧
    # typeset -A key
    # key=(
        # BackSpace  "${terminfo[kbs]}"
        # Home       "${terminfo[khome]}"
        # End        "${terminfo[kend]}"
        # Insert     "${terminfo[kich1]}"
        # Delete     "${terminfo[kdch1]}"
        # Up         "${terminfo[kcuu1]}"
        # Down       "${terminfo[kcud1]}"
        # Left       "${terminfo[kcub1]}"
        # Right      "${terminfo[kcuf1]}"
        # PageUp     "${terminfo[kpp]}"
        # PageDown   "${terminfo[knp]}"
    # )

# bindkey -m
# -m  | add builtin meta-key (win键) bindings to selected keymap






# autoload一个函数和source函数所在文件，效果一样？

# autoload -U:
# 1. autoload: 把fpath定义的函数load进来，这样才能调用。类似python的import？
# 2. -U  | suppress alias expansion for functions  (记作unalias?  )


# https://unix.stackexchange.com/a/677162/457327
autoload -U history-search-end
# -k  | mark function for ksh-style autoloading
# -z  | mark function for zsh-style autoloading

zle -N   history-beginning-search-backward-end        history-search-end
zle -N   history-beginning-search-forward-end         history-search-end


# bindkey "$key[Up]" history-beginning-search-backward-end
# bindkey "$key[Down]" history-beginning-search-forward-end
### 比上面2行更灵活
bindkey "$key[Up]" history-substring-search-up
bindkey "$key[Down]" history-substring-search-down


bindkey "$key[Home]" beginning-of-line
# `Escape character`的ascii码的十进制 十六进制 表示:
    # 八进制          \033
    # 十进制          27
    # 16进制          \x1b  或者\x1B
    # 用转义序列表示  \e
    # ctrl-key        ^[      ^是Caret(敲ctrl), 加上[ 就成了ESC


# Control Sequence Introducer: sequence starting with `ESC [`,  即`^[[`


bindkey "$key[End]" end-of-line
# 或者

# todo 参考:
bindkey "$key[Delete]" delete-char
# bindkey "\e\d"  undo  # alt-bs

bindkey '^ ' delete-word



# vi mode 出问题来这里

# alt键：\e

# ctrl作为前缀：
# 1. `\C-x',
# 2.  `^x'
# `-m' option to bindkey tells zsh that wherever it binds an escape sequence like `\eb', itshould also bind the corresponding meta sequence like `\M-b'.
# 不加-m的话：you can rebind them separately. and if you want both sequences to be bound to a new command, you have to bind them both explicitly.


# ctrl p/n  和 上下箭头 只能找到以特定内容开头的历史命令，这个可以所有？
# These are all the same.
    #  <alt>+b <esc>+b <Meta>+b   M-b \eb,
    #  e: 表示escap吧

# bindkey -s '^j' 'echo "vscode在用" \n'  #别改 ^j ，^j和\n同体？
# bindkey '^m' 和回车键 同体


# \e表示Esc键，但敲alt也行. 先按Ecs键，再按字母，等价于：按下alt，再按字母
# 默认就是吧:
# b: backward-word
# f: forward-word

bindkey -s '\ei' 'echo "待用" \n'
bindkey -s '\ep' 'echo "待用" \n'


# todo
# DIRSTACKSIZE=15 # Setup dir stack
# setopt autopushd  pushdminus pushdsilent pushdtohome pushdignoredups cdablevars
bindkey -s '\eu' '..\n' # u for up  # 不行： bindkey -s '<atl>+u' '..\n'

# bindkey -s '\ek' '.. \n'  # 目录 前进一次

# # autohotkey 使得lalt & vk88, 实现了这功能.避免干扰zsh-vim-mode:
# bindkey -s '\el' 'cd - \n'  # 目录 后退一次

# bindkey '\ek' up-line-or-history
bindkey '^p'  up-line-or-history  # 有了history-substring-search-up 似乎用不到了
# ^p 本来是 history-beginning-search-forward, 搜以当前已敲内容开头的history 用↑代替了

# bindkey '\ej' down-line-or-history
bindkey '^n'  down-line-or-history

#可以换成别的功能
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line
bindkey '\ee' backward-word

# bindkey '\el' forward-word  # 被插件改了？行末
# bindkey -r '\el'  # 不生效，被zsh vim模式插件占了？

# bindkey -s '\e/' 'll\n'
# 留给vim 用作复制一行并注释

bindkey '\ex' execute-named-cmd
# 待阅 https://www.cs.colostate.edu/~mcrob/toolbox/unix/keyboard.html



#这3行 都会显示alt最为prefix的键位
# bindkey -p "\033"
# bindkey -p "\e"
# bindkey -p "^["

# https://sgeb.io/posts/zsh-zle-custom-widgets/
# bindkey -s '^[^H' 'echo "ctrl alt H"'   # 被zsh-vim-mode占用？
#
bindkey -s '^h' 'echo "被tmux占了" \n'
bindkey -s '^l'   'echo "tmux要用" \n'
# bindkey -r '^l'   # -r unbind  r记作reload吧


#
# bindkey -s '^i'   # 不能改, 这货和tab同体


# setup for deer
# autoload -U deer
# zle -N deer
# bindkey ............

# select viins keymap and bind it to main
# bindkey -v 别在这里用,放在rc.zsh的zplug那块的zsh-vim-mode插件附近吧

# 改了不生效
# bindkey '^x^e' vi-find-next-char
# 暂时没有用的键
# bindkey '^g'


# json里写不了注释：
# C-c	peco.Cancel

# 不知道怎么用, 敲了没反应：
# C-k	 peco.KillEndOfLine
# C-t	peco.ToggleQuery:  Toggle list between filtered by query and not filtered.

# 熟悉后删掉：
# C-u	    peco.KillBeginningOfLine
# C-w	    peco.DeleteBackwardWord
# C-n	    peco.SelectDown
# C-p	    peco.SelectUp

# C-r	    peco.RotateFilter

function peco-find-file() {
    local tac
    if which tac > /dev/null  # # 把送到stdout /bin/tac啥的 扔到"黑洞". 只作判断,用户不需要看到stdout
    then
        tac="tac"
    else
        tac="tail -r"
        # BSD 'tail' (the one with '-r') can only reverse files that are at most as large as its buffer, which is typically 32k.
        # A more reliable and versatile way to reverse files is the GNU 'tac' command.
    fi

    # 见alias.zsh里的f()
    if [[ `pwd` == "$HOME/d" || `pwd` == "/d" ]]
    then
        # BUFFER (scalar):   The entire contents of the edit buffer.
        # https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#index-BUFFER
        BUFFER=$(find . \
        -path "/d/docker" -prune -o  \
        -path "$HOME/d/docker" -prune -o  \
        -path "$HOME/d/.t" -prune -o       \
        -path "$HOME/t" -prune -o       \
        -path "./.t" -prune -o       \
        -name "*$1*"  | peco --query "$BUFFER" )
        # 别用系统的根目录下的peco，太老，用dotF下的
        CURSOR=$#BUFFER

        # echo '当前路径为： ~/d'
        # echo '(没进去搜的目录, 仍会输出一行 )'
    else
        BUFFER=$(find . \
        -path "/d/docker" -prune -o  \
        -path "$HOME/d/docker" -prune -o  \
        -path "$HOME/d" -prune -o       \
        -path "./d" -prune -o       \
        -path "$HOME/d/.t" -prune -o       \
        -path "$HOME/t" -prune -o       \
        -path "./.t" -prune -o       \
        -path "/proc" -prune -o      \
        -path "/dev" -prune -o      \
        -name "*$1*"  | peco --query "$BUFFER" )
        # 别用系统的根目录下的peco，太老，用dotF下的
        CURSOR=$#BUFFER

        # echo '不搜 ~/d 或  /d '
        # echo '(没进去搜的目录, 仍会输出一行 )'
    fi
}


zle -N peco-find-file
bindkey '^F' peco-find-file

function peco-history-selection() {
    local tac
    # GNU 'tail' can output any amount of data (some other versions of 'tail' cannot).
    # It also has no '-r' option (print in reverse), since reversing a file is really a different job from printing the end of a file;
    if which tac > /dev/null  # 把送到stdout /bin/tac啥的 扔到"黑洞". 只作判断,用户不需要看到stdout
    then
        tac="tac"
    else
        tac="tail -r"
        # BSD 'tail' (the one with '-r') can only reverse files that are at most as large as its buffer, which is typically 32k.
        # A more reliable and versatile way to reverse files is the GNU 'tac' command.
    fi
    # 别用系统的根目录下的peco，太老，用dotF下的
    # -1000: 最近1000条历史
    # tac后，最新的在最上
    # cut -c 8-  去掉序号和空格
    # 命令前加个\，避免多个alias打架了
    # 正则， 通配年-月-日 时:分:秒："\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}\\s{2}"
    # history:  其实是 fc -l 的alias  fc记作find command history吧


    # todo 下次别再搞那么复杂，记住就删掉这几行----
    # WFpeco= `$HOME/dotF/peco --rcfile /root/.config/peco/config_for_peco_history.json`
    # $WFpeco 不是想要的结果
    # BUFFER=$(history -i -2000 | eval $tac | cut -c 8- | $HOME/dotF/peco --rcfile /root/.config/peco/config_for_peco_history.json --query "\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}\\s{2} $BUFFER")
    # todo 下次别再搞那么复杂，记住就删掉这几行----

    BUFFER=$(history -i -2000 | eval $tac | cut -c 8- | peco --initial-filter="Regexp" --query "\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}\\s{2} $BUFFER")
    BUFFER=${BUFFER:18}  # history加了-i，显示详细时间，回车后只取第19个字符开始的内容，（删掉时间)
    CURSOR=$#BUFFER
    # 这个表示 数后面的字符串长度 ：$#
    # BUFFER改成其他的，不行
    # CURSOR变成小写 就不行了

     # 我没存peco的源码 “Yes, it is a single binary! You can put it anywhere you want"
}
zle -N peco-history-selection
# bindkey '^R' peco-history-selection  # 放到bindkey_wf.zsh里
bindkey '^R' peco-history-selection

bindkey -s "\C-q" "echo 'ctrl-q: 待用' \n"
