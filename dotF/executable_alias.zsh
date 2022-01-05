# The shell evaluation order (per POSIX) for the entities in your question is:
# aliases 优先于  variables --> command substitutions --> special built-ins --> functions --> regular built-ins

# oh my git    oh my god
alias omg='chezmoi'

# 在~/dotF/bin_wf 下
alias names='massren'
alias rename='massren'
#  never use normal sudo to start graphical applications as root
# 否则普通用户可能无法登陆（文件变成root的了）
#

alias fzf='~/dotF/fuzzyF/bin/fzf --height 40% --layout=reverse --border'

alias cfg='~/dotF/cfg/'

export CHTSH_CONF='~/dotF/cfg/cht.sh.conf'
alias ch='cht.sh --shell'

# cheat website
chw(){
    # curl --silent "cheat.sh/$*""\?T" | bat
    # 要下面这样写才行：
    tmp="cheat.sh/$*"
    curl --silent $tmp\?T | bat
    }

alias nvtop='/home/wf/nvtop_wf_built/usr/local/bin/nvtop'

aps(){
    apt search $1 | peco
}

# file1=`cat answer.txt` 不及：
# file1 = $(cat answer.txt)  # 能避免特殊字符发挥作用


# alias echo='print "正在用print代替echo" && print -l'
alias ec='print -l && print "正在用print代替echo" '

alias version='~/dotF/show_version_of_any_tool/version'
alias ver='~/dotF/show_version_of_any_tool/version'

alias grep='grep --color=always'
alias gr='grep'


ht(){
    # 把这个视为“std重定向符”：  >&
    # 2>&1  : stderr > stdout
    # 2>1  1会被当作为文件名
    # https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean

    nohup $* 2>&1 &
    # 例子：
    # ht python train.py > ./mylog.txt
    # 这样就把stderr重定向成stdout，stdout重定向到mylog.txt,  敲完这行，命令行没有输出，继续敲下一个命令
}

# 失败：
# https://stackoverflow.com/questions/58225759/how-do-i-copy-and-paste-bash-without-dollar-signs
# ud() { . <( sed 's/^\$ //' ); }
# undollar() { . <( sed 's/^\$ //' ); }


# # 敲`zsh 某.sh`时，这里的东西全都不起作用. 覆盖built-in命令也不怕翻车
# 博客也有教覆盖的：https://www.tecmint.com/create-and-use-bash-aliases-in-linux/
# alias r='~/.local/bin/tldr'  # pip安装的，比apt安装的显示好些 但不翻墙就有时连不上网。。。。。翻了也用不了....
h(){
    /usr/bin/tldr $1 | bat
    # todo https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    # parameter expansion
    VAR="$(/usr/bin/tldr $1)" # 赋值时千万别写空格！！
    if [[ ${VAR} == *"No tldr entry for"* ]]
    then
        run-help $1
    fi
    # todo
    # man可以指定pager,  less这个pager可以指定打开的位置
    # man --pager="less --pattern 'keyboard definition'" zshcontrib
}
# built-in的r:    Same as fc -e -      重复你敲的上一条命令
# help zshbuiltins 查看内置命令


# 改了函数以后，敲source ~/.zshrc, 不生效。要新开zsh

# `env -i` 比“\”更强, 解决了2的缺点   https://stackoverflow.com/questions/6162903/why-do-backslashes-prevent-alias-expansion
# 函数与别名：1 定义函数后， alias 原=函数名。好处：敲`\原` ，能使用原命令，坏处：`co 原` 后，要多敲`co 函数名`
#            2 直接定义 my_func_ls(){ }      与上面相反. 【注意函数名别和built-in重复】


alias cle='clear -x'
q(){
    tree -L 2 --filelimit=50 $1 | peco
}

git_rm_sub(){
    sub_name=$1
    git submodule deinit -f $sub_name
    rm -rf .git/modules/$sub_name
    git config -f .gitmodules --remove-section submodule.$sub_name
    git config -f .git/config --remove-section submodule.$sub_name
    git rm --cached $sub_name
    git commit -m "彻底清理submodule: $sub_name"
}

# alias git='LANG=en_GB git' # 不行

zi(){
    # https://unix.stackexchange.com/questions/161905/adding-unzipped-files-to-a-zipped-folder

    # [[ -a FILE_NAME ]], the "! -a" asks if the file does not exist.
    # https://www.cnblogs.com/itxdm/p/If_in_the_script_determine_the_details.html
    # https://zhuanlan.zhihu.com/p/361667506

    # test 等价于 [ 你的条件 ], 这个更先进： [[ 你的条件 ]]
    if [[ -f ~/tmp_at_home.zip ]]; then
    # if [[ -f '~/zip_folder/' ]]; then   # 用引号包住文件路径，就成了string， -f判断的是file。这里才要加引号(包住的是$加上变量）： if [ "$testv" = '!' ]; then
        t ~/tmp_at_home.zip
    else
        echo "放心, tmp_at_home.zip之前不存在"
    fi

    # todo
    # zip -r foo foo --exclude \*.cpp \*.py
    # if [[ -d $2 ]]   #$2是文件或目录
    # then
        # echo 不收纳"$2" 但貌似会在压缩包里 建立一个同名目录
        # zip -r ~/tmp_at_home.zip "$1"  -x  "$2"
    # else
        # zip -r ~/tmp_at_home.zip $1
    # fi

    zip -r ~/tmp_at_home.zip $1
    # 看多大：
    du --summarize --human-readable ~/tmp_at_home.zip

}

# () 含义：declaring a function.
unzip_multi(){
    #  for 循环不放文件最开头 就报错，奇怪了
    for x in $*
    do
        #${varible:n1:n2}:截取变量varible从n1到n2之间的字符串。 类似python
        dir=${x:0:-4}
        \mkdir ${dir}
        unzip ${x} -d ${dir} && t ${x}
    done
}
alias -s zip=unzip_multi

# Use [] : if you want your script to be portable across shells.
# Use [[]] : if you want conditional expressions not supported by `[]` and don't need to be portable.
#

alias nls='export chpwd_functions=()'
# alias cd='export chpwd_functions=() ; builtin cd' #  加了这行，就算没敲cd，chpwd_functions也废掉了



# >_>---------------------------------------------------------关于mtime--------------------------------->_>
# -print0: uses a null character to split file names, and
# --null 或者 -0： expect NUL characters as input separators
# stat --format ''
# %y :  time of last data `modification`
# tac  倒着列出  # cat倒过来
# %y表示  `modify time`
mt(){
    # todo: 送到peco
    echo '如果在目录下新增内容，该目录的mtime会变。如果只是修改其下内容，该目录的mtime不变'
    # %y得到的  +0800表示东八区
    find $1 -type f -print0 | xargs --null stat --format "%y 改%n"  | \
    sort --numeric-sort --reverse | \
    head -100 | \
    cut --delimiter=' ' --fields=1,2,4 | \
    awk -F " " \
    '{OFMT="%.6f" ; \
    print NR"】", \
    $1,           \
    " ",          \
    $2,           \
    " ",          \
    $3            \
    }'  | bat   # 这里不能用双引号代替单引号
    # date --date="${UglyTime}"  +"%Y年%m月%d日 %X"` | \
    # PrettyTime=`date --date="${UglyTime}"  +"%Y年%-m月%-d日 %X"
    # \grep : --color=always
}
# access time
# mtime变了，ctime跟着变。ctime变了，atime跟着变
# https://zhuanlan.zhihu.com/p/429228870  # atime不是很可靠
# at(){
#     find $1 -type f -print0 | xargs --null stat --format '%x Acess%n'  | \
#     sort --numeric-sort --reverse | \
#     head -100 | \
#     cut --delimiter=' ' --fields=1,2,4 | \
#     tac | \
#     awk -F " " \
#     '{OFMT="%.6f" ; \
#     print NR"】", \
#     $1,           \
#     " ",          \
#     $2,           \
#     " ",          \
#     $3            \
#     }' | bat    # 这里不能用双引号代替单引号
# }

# ct(){
#     echo 'status （meta data) changed 时间, 当作birth time吧，birth没记录'
#     find $1 -type f -print0 | xargs --null stat --format '%z metadata被改%n'  | \
#     sort --numeric-sort --reverse | \
#     head -100 | \
#     cut --delimiter=' ' --fields=1,2,4 | \
#     tac | \
#     awk -F " " \
#     '{OFMT="%.6f" ; \
#     print NR"】", \
#     $1,           \
#     " ",          \
#     $2,           \
#     " ",          \
#     $3            \
#     }' | bat --language=Python   # 这里不能用双引号代替单引号
# }

# The closest you can get is the file's ctime, which is not the creation time, it is the time that the file's metadata was last changed.

# | cut -d: -f2-
#  百分号加字母，在不同命令有不同含义。表示时间时，有些时候不同命令某些程度上一致
#   Convert a specific date to the Unix timestamp format
# date --date="某个表示时间的字符串" '+%格式代码'
# 例如：
# date --date="1may" '+%m%d'
# date --date="may1" '+%m月%d日  没加百分号的字符 随便写'
#‘-’ : suppress the padding altogether:
# date --date="may1" '+%-m月%-d日'
#
# echo "$(stat -c '%n %A' $filename) $(date -d "1970-01-01 + $(stat -c '%Z' $filename ) secs"  '+%F %X')"
# %Y     time of last data modification, seconds since Epoch
# <_<---------------------------------------------------------关于mtime-----------------------------------<_<

#移到垃圾箱
alias tvsc='t'




# 作为函数 不能同名, 无限递归？
# maximum nested function level reached; increase FUNCNEST?
# rg(){
#     \rg --pretty --hidden  \
#     $*
#     # $* | bat  # 导致无法自动补全
# }
#

# 作为alias 可以同名
alias rg='\rg --pretty --hidden --smart-case'



# 用了这个不能自动补全
# 还是有点问题：
# copy file content
cfc(){
if [[ $DISPLAY != '' ]];then     # -z: 看是否empty
# Localhost: server that is used on your own computer
   cat $* | xsel --input --clipboard
else
    echo "没有开x11吧"
fi
}


alias ca='cat'
alias ba='bat'
alias w=bat

# bat read git output
bgit(){git $* | bat}

# /home/wf/dotF/color_less_wf.zsh 里，export LESS='--quit-if-one-screen 一大串.....'
alias le="less  --quit-if-one-screen"
# alias le="less  "


# todo 结合peco
#  a 强行记忆法：at the snippet
#  改了.  还是用r吧，recursively  grep. (ripgrep, 不知道啥意思。)
r(){
     \rg --pretty \
         --glob=!"$HOME/.t" \
         --glob=!"$HOME/d" \
         --iglob=!"~/.zsh_history" \
         --iglob=!"$HOME/.zsh_history" \
         --iglob=!"./.zsh_history" \
         --glob=!"/d" \
         --hidden \
         --before-context 1 \
         --after-context 2  \
         --smart-case "$*" |  less --pattern="$*"
         # --iglob:  case insensitve
     echo '没搜~/.t  ~/d  /d'
     echo 'todo，.zsh_history怎么去掉？'
                            # alias le="less  --quit-if-one-screen"
}


rd(){
     \rg --pretty \
         --glob="$HOME/d" \
         --glob="/d" \
         --hidden \
         --before-context 1 \
         --after-context 2  \
         --smart-case "$*" |  less --pattern="$*"
                            # alias le="less  --quit-if-one-screen"

     echo '只搜 ~/d  /d'
}

r4(){
    # read TMP
    # TMP2 ="`print -r ${(q)TMP}`"
    # \rg --pretty --hidden TMP2 | bat # 沿用ag的a
     \rg --pretty \
         --hidden \
         --before-context 4 \
         --after-context 4  \
         --smart-case "$*" |  less --pattern="$*"
                            # alias le="less  --quit-if-one-screen"
}

alias ac='_ack(){ ack "$*";};_ack'

#找到软链接的真实路径
alias rl='readlink -f'
#j for jump
alias j='ln -s --interactive --verbose --logical'
#logical: dereference TARGETs that are symbolic links

# cm for command
# 代替where which type
# -v for verbose, 不过好像没用
alias cm='whence -ca'

alias help=run-help

#==============================ls相关===================================
# todo 现在exa和ls混用, 最好统一一下
alias ls='\ls -hrt --color=always'
# alias ls='ls | awk "{print $4,$5,$6,$7, $3}"'
alias la='\ls -ACF1GhFtr --color=always --classify'
alias lc='lt -c'
alias lla='\ls -gGhtrFA --color=always'
alias lr='ls -gGhtF --color=always'
alias lt='ll -tr'
alias lx='\ls -l'
alias l.='\ls -d1 .* --color=always --classify'
# list lean
alias ll='\ls -1htr --color=always --classify | head -30'
# list full:

# lf(){
#     # --classify:   append indicator (one of */=>@|) to entries
#     #-g  -l时不显示用户名
#     \ls -g -htrF \
#         --no-group \
#         --color=always --classify $* \
#         | cut -c 14- \
#         | sed 's/月  /月/' \
#         | sed 's/月 /月_/' \
#         | bat
#         # | ag ':'
#         # | ag ':' --colour=always \
#     tmp=$((`\ls -l | wc -l`-1))
#     echo "列了所有：${tmp}"
# }
lf(){
    $HOME/dotF/exa/bin/exa \
    --long \
    --classify \
    --colour=always \
    --header  \
    --no-user  \
    --no-permissions  \
    --sort=time  \
    --time-style=iso $1 | less
    # --group-directories-first    # 不好，

    tmp=$((`\ls -l | wc -l`-1))
    echo "共：${tmp}"
}

l(){
    $HOME/dotF/exa/bin/exa \
    --long \
    --classify \
    --colour=always \
    --header  \
    --no-user  \
    --no-permissions  \
    --sort=time  \
    --time-style=iso  $1 | \
    tail -25
    # --group-directories-first    # 不好，

    tmp=$((`\ls -l | wc -l`-1))
	if [   $tmp     -lt      25 ];  then
		echo "--------------"
	else
        echo "--------文件数：25/${tmp}---------"
	fi
}

# [[===========================================================================被替代了,先放这儿
# alias l=leo_func_ls
#写成l()会报错。可能和built-in冲突了
# leo_func_ls(){
#     # --classify:   append indicator (one of */=>@|) to entries
#     #-g  -l时不显示用户名
#     \ls -g -htrF \
#         --no-group \
#         --color=always --classify $* \
#         | cut -c 14- \
#         | tail -25 \
#         | sed 's/月  /月/' \
#         # | sed 's/月 /月_/' \
#         # | ag ':'
#         # | ag ':' --colour=always \
#     tmp=$((`\ls -l | wc -l`-1))
#     if [   $tmp     -lt      25 ]
#     then
#         echo "--------------"
#     else
#         echo "--------文件数：25/${tmp}---------"
#     fi
# }
# [[===========================================================================被替代了,先放这儿

# 改变目录后 自动ls
list_all_after_cd() {
    # to make your zsh script portable and reliable :
    # use zsh's `built-in features`
    # add `emulate -L zsh` to  the body of your script or function,  to start from a known state.
    # 避免setopt等搞乱默认配置
    emulate -L zsh
    # -L  | set local_options and local_traps as well
    # -R  | reset all options instead of only those needed for script portability
    #  模拟 csh ksh sh 或者 （没加配置的）zsh

    $HOME/dotF/exa/bin/exa \
        --long \
        --classify \
        --colour=always \
        -F  \
        --group-directories-first  \
        --header  \
        --no-user  \
        --no-permissions  \
        --sort=time  \
        --time-style=iso  | \
        tail -8

    # \ls -gGhtrFB --color=always --classify $* | cut -c 14- | tail -5
    tmp=$((`\ls -l | wc -l`-1-8)) #文件总数: `\ls -l | wc -l`-1
    if [ $tmp -lt 0 ]; then
        echo "------no more files--------"
    else
        echo "--------未显示文件数：$tmp---------"
    fi
}
date_leo(){
    print "{<time of ls:"`date  +"%d日%H:%M:%S"`">}"
}

# $chpwd_functions:  shell parameter (an array of function names.)
# All of these functions are executed `in order` when changing the current working directory.
# 类似PAHT=$PATH:某目录，  我猜这么append函数名
# chpwd_functions=(${chpwd_functions[@]} "函数1")
#

# 没看错，中文能当变量
换行=$'\n'
上行=$'\e[1A'
上行=$'\e[1B'
autoload -U colors
colors
PS1_leo(){
# https://void-shana.moe/linux/customize-your-zsh-prompt.html
# 放文件开头时，颜色时有时无
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
# PS1="%{$fg[cyan]%}【82服务器】%~       %T_周%w号"${换行}">%{$reset_color%}"
# myPS+="${换行}"

print ${fg[cyan]}`pwd`${reset_color}
}


# /usr/share/zsh/functions/Chpwd  下有chpwd_recent_dirs等
# 默认的 chpwd_functions 只含chpwd_recent_dirs一个函数
# @表示取array里的所有东西，类似于python的list[:], 但冒号不能换成具体数字?
chpwd_functions=(${chpwd_functions[@]} "PS1_leo")
chpwd_functions=(${chpwd_functions[@]} "date_leo")
chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")

# 加了这行，就算没敲cd，chpwd_functions也废掉了:
# alias cd='export chpwd_functions=() ; builtin cd'



#==============================ls相关===================================]]


# >_>_>edit want python trash=============================================begin
# w: want
# e: edit (nvim或code)
# p: python
# b: pudb
# t: trash


alias e='nvim'
# edit diff
alias ed='nvim -d'
if [[ $HOST != 'redmi14-leo' ]] && [[ -z "$TMUX" ]];then  # 远程服务器且用vscode
    alias e='code'
    alias ed='code -d'
fi

# ed是一个没啥用的系统bin
alias vd='nvim -d'

alias ep='e'
alias eb='e'
# alias epe='e'  # 太复杂了，先不搞


t() {
    for my_file in $*
    do
        ori=`basename ${my_file}`
        trash=`basename ${my_file}`_`date  +"%m月%d日%H:%M:%S"`
        mv ${my_file} ~/.t/${trash} && echo "${ori}扔到了~/.t"
    done
}

alias tw=t
alias te=t
alias tp=t
alias tb=t

# 第一次用才需要
# alias p='python3 -W ignore -m pretty_errors'
p(){
    chpwd_functions=()
    \python3 -W ignore $*  # 打断后就不再执行下面几行
    chpwd_functions=(${chpwd_functions[@]} "list_all_after_cd")
}
alias python='p'
alias python3='p'

alias pb='p'
alias pe='p'
alias pw='p'

alias b='pudb3'

alias bp='b'
alias be='b'
alias bw='b'

alias ee='p'
# ahk has set:
    # insert & v::
    # send, ^a
    # send,v
    # return

# want python pudb edit===================================================<_<_<

# ~/.antigen/bundles/sorin-ionescu/prezto/modules/utility
md(){
    for x in $*
    do
        if [ -d "${x}" ]; then
            echo "已存在:$x"
            # mkdir 不会覆盖已有目录
            # 只是想echo一下，提醒自己 尽量回忆起 之前为什么创建了目录
        else
            \mkdir -p "$x"
        fi
    done
}
# 尽量别覆盖原本的命令名
# alias mkdir='md'

cl(){
    echo $((`\ls -l | wc -l`-1))
    }




# gpustat and grep wf
alias g='echo "gpu序号记得减1";  gpustat  --show-user --no-header  | cut --delimiter="," -f2 | bat  --number --language=py3 '
alias gw='g --your-name wf '
alias gwf='g --your-name wf '

alias gi='gpustat  --show-user --no-header --show-pid'
alias giw='gi --your-name wf'
alias giwf='gi --your-name wf'

alias au='apt update'

alias nv='nvidia-smi'

# count line number
#$ echo "$((20+5))"
#25
#$ echo "$((20+5/2))"
#22

# edit tempt
alias et='e ~/d/tmp.py'
# try tempt
alias tt='python ~/d/tmp.py'
# bd : 本地
alias bd='e ~/.zshrc ; zsh'
# alias jn='jupyter notebook'

alias con='conda'
alias ci='conda install -y'
# conda create --name new_name --clone old_name
# conda remove --name old_name --all # or its alias: `conda env remove --name old_name`

alias snp='~/dotF/wf_snippet.py'


# Sometimes it is convenient to create separate tmux servers,
# perhaps to ensure an important process is completely isolated or to test a tmux configuration.
# S socket-path:  Specify a full alternative path to the server socket.
# If -S is specified, the default socket directory is not  used and any -L flag is ignored
alias tmux='\tmux \
            -S ~/d/.socket_file_for_tmux_svr  \
            -f ~/dotF/tmux_wf/tmux.s'

tm() {
    # https://stackoverflow.com/a/29369681/14972148
    # export MY_VAR="some value"
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        tmux  new -s s_$1 || tmux attach -t s_$1  -d
    else
        tmux  new -s s_初代 || tmux attach -t s_初代 -d
    fi
}

bk(){
    for my_file in $*
    do
        echo ${my_file}
        mv ${my_file} .bk_${my_file}_`date  +"%m月%d日%H时%M分"`
    done
    }

# if you used git commit -m "${1:-update}" (a parameter expansion with a default provided), then you wouldn't need the if statement at all
# gitall() {
    # git add .
    # if [ "$1" != "" ] # or better, if [ -n "$1" ]
    # then
        # git commit -m "$1"
    # else
        # git commit -m update
    # fi
    # git push
# }



#find . -maxdepth 1 -printf '%Cm月%Cd日   %CH:%CM:%CS    %s         %f \n'
#要传参，比如用$,要用函数，不能直接用别名
# http://blog.tangzhixiong.com/post-0035-pkg-config.html

# if $1 expands to demo , then ${1%.wf_run} 把传进来的文件名的后缀wf_run扔掉
# if $1 expands to demo , then ${1%.*} expands to demo  ??
alias oc='_oc(){ g++ -g $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# oc demo.cpp draw.h draw.cpp
# ./demo

alias nvim='~/dotF/nvim-linux64/bin/nvim'
alias vim='~/dotF/nvim-linux64/bin/nvim'
alias vi='~/dotF/nvim-linux64/bin/nvim'   # 不用加-u 指定 因为默认就在~/.config/下
# alias vim='~/dotF/nvim-linux64/bin/nvim -u ~/dotF/cfg/nvim/init.vim'


# 用autohotkey敲\ec吧
# ech(){
#   涉及到变量替换, 搞了很久没成功
    # printf $$1  # 输出3290431
    # printf ${$1}
    # echo $1>$HOME/.t/ec_leo_short_for_echo.txt

    # cat $HOME/.t/ec_leo_short_for_echo.txt | echo ${}
    # echo  ${"echo $1"}

    # if (( ${+$(VAR)} ))   #  看 VAR是否未设置
    # then
        # echo $(VAR)
    # else
        # echo "$1 未设置"
    # fi
# }

alias sc='scp'
alias scp='scp -r'
# alias scp='sshpass -p "你的密码" scp -r '
# tr本来是linux的builtin
# 最近15个文件
# printf 命令 指定格式


#都说别改动或者覆盖linux的builtin!
# 最规范的语法 alias custom-alias='command'  command 里面没空格就不用引号
# {后一定要有空格
# []  和{}内侧左右都留一个空格 不然可能报错
# [ your_code ]才对  [your_code]少了空格
# 需要vim的语法检查时，改后缀名.sh再打开
# 双引号换成单引号就不行
# alias vj='_j(){ jq -C '' $1 ; }; _j'
# 最外层用双引号也不行
# alias vj="_j(){ jq -C "" $1 |bat -R;};_j"

# 还可以用:
# n
# p
# x


alias sa='chmod -R 777'  #share to all
alias t_a='t *'
alias sc='noglob scp -r'
alias scp='noglob scp -r'
# tac:
# Print and concatenate files in reverse (last line first)




##tr 更合适 但它是translate命令
##q for query查询
##换行输出
##echo "${PATH//:/$'\n'}"
##echo "${fpath// /$\n}"


alias pt='ptpython --vi'
#alias pt='ptpython --vi --config-dir=~/dotF/cfg/ptpython'
alias pti='ptipython --vi'
alias matlab='matlab -nosplash -nodesktop'
# alias ml='matlab -nosplash -nodesktop'
# 避免sudo后的alias失效？
# alias sudo=''

alias tc='e ~/dotF/tmux_wf/tmux.s'
alias s='e ~/dotF/rc.zsh ; zsh'

# az: 安装an zhuang
alias az='e ~/dotF/auto_install/auto_install.sh'
# al: alias
alias al='e ~/dotF/alias.zsh; zsh'

# i for init.vim
alias in='e ~/dotF/cfg/nvim/init.vim'  # init.vim


#y: yyds，我的配置yyds
# alias y=sy

# get github
gg(){
    chpwd_functions=()  # 别显示 所去目录下的文件
    cd ~/dotF
    # echo "\n-----------1. stash，藏起本地修改（但忽略新增文件）------------"
    git stash --include-untracked --message="【stash的message_`date  +"%m月%d日%H:%M"`】"
    # echo "\n-----------------2. pull, 拉远程的新代码-----------------"
    git pull  # Update the branch to the latest code   = fetch + merge? 还是只fetch?
    # echo "\n如果giithub上领先于本地，那么 此时本地的修改还被藏着，现在打开本地文件和github上一样"
    # echo "\n---------------------3. stashed的东西并到 本地的当前代码 ---------------------"
    git stash pop  # Merge your local changes into the latest code, 并且在没有conflict时，删掉stash里的这个东西
    # 貌似比git stash apply好
    # echo '会报：Dropped refs/stash@{0}'
    # echo "\n 【亲，检查一下有没有冲突】 "
}

# 我最新的配置 真是yyds
yy(){
    # echo "\n--------------------------------4. add commit push三连-----------------------------------------------"
    cd ~/dotF
    git stash clear  # 避免pull后有冲突，合并完后，再敲gg，死循环地有冲突
    echo "\n--------------------------------add commit push三连-----------------------------------------------"
    git add --verbose  --all .
    if [[ "$1" != "" ]]  # if [[ "$1" == "" ]] 容易出bug？一般都不这么写
    then
        # 不加--all时，如过github有些文件，而本地删掉了，则github上不想要的文件 还在
        git commit --all --message "$1"
    else
        git commit --all --message "我是commit名__`date  +"%m月%d日%H:%M"`"
    fi
    git push --quiet  #  只在出错时有输出
    # git push 2>&1 >~/.t/git_push的stdout  # 不行
    cd -
    zsh
}



# todo  # alt left 搞成和windows一样的体验
# }

# Shell functions are defined with the function reserved word or the special syntax ‘funcname ()’.
# function d () {

d () {
    dirs -lv | head -10  > ~/.t/.leo_path_stack_dirs.log
    # -v 带上序号
    # -l  代表long？ full path
    bat ~/.t/.leo_path_stack_dirs.log
}
compdef _dirs d  # 让函数d能被自动补全

# _dirs is an autoload shell function
#
# whence dirs输出：
# _dirs () {
#         # undefined
#         builtin autoload -XUz
# }
#
# /usr/share/zsh/functions/Completion/Zsh/_dirs 的完整内容:
#compdef dirs
# _arguments -s \
#   '(-)-c[clear the directory stack]' \
#   '(* -c)-l[display directory names in full]' \
#   '(* -c)-v[display numbered list of directory stack]' \
#   '(* -c)-p[display directory entries one per line]' \
#   '(-)*:directory:_directories'

# global alias，有点危险， 别用
# alias -g ...='../..'

alias -- _='cd -'
alias -- -='cd -'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'

# 光标
alias gb='echo -e "\033[?25h"'
#加了这行导致./build_ops.sh等执行不了
#alias alias -s sh=vi
#大小写不敏感  If you want to ignore .gitignore and .hgignore, but still take .ignore into account, use -U
alias c=cp
alias cp='cp -ivr'
alias c.='cp -ivr -t `pwd`'
alias df='df -h | bat'
# bie dai li，别代理
alias bdl='unset ALL_PROXY; pqi use tuna; conda conf'

alias dkr='docker'
alias dkrps='docker ps -a --format "table {{.Names}} 我是分隔符 {{.Image}}  "'
# zsh启动不了时, 并不会启动bash, 搁置

dk(){
docker start $1 ; docker exec -it $1 zsh
# docker exec -it $1 zsh 在退出时不返回1  ?
#  这样会一直卡着: echo `docker exec -it $1 zsh`
}


alias peco='$HOME/dotF/bin_wf/peco --rcfile $HOME/.config/peco/config.json'


# stat:  BSD style, 比state的内容详细
# state: standard sytle
# format里面那一堆，不能有空格
# psp: process status 送到peco

# alias psp='ps --headers  --User "${1:-$LOGNAME}" --format=pid,start_time,cputime,stat,comm,command | peco'
# zsh-syntax-highlighting 把他当作unknown token
## 因为在alias中用了`| peco` ?  但`| head` 又没这问题
psp(){
    ps --headers  \
    --User "${1:-$LOGNAME}" \
    --format=pid,start_time,cputime,stat,comm,command | peco
}

# 我自己的回答
# https://unix.stackexchange.com/a/680293/457327

pid(){
    # echo "pid |  开始于  在跑吗  %CPU  %MEM   |  CPU占用 [DD-]hh:mm:ss |  程序  |   完整路径"
    echo '状态：
    R    running or runnable (on run queue)
    S    interruptible sleep (waiting for an event to complete)
    s    a session leader
    l    multi-threaded
    +    foreground process
    '

    # TIME: amount of CPU in minutes and seconds that the process has been running

    # 加了循环报错，错了done啥的
    # for pidN in $*
    # do
        echo '------'
        # ps --headers --pid=$pidN --format=pid,start_time,stat,comm,command
        # ps --headers  --pid=$pidN --format=pid,start_time,cputime,stat,comm,command
        ps --headers  --pid=$* --format=pid,start_time,cputime,stat,comm,command


        # TIME::accumulated cpu time, user + system 比真实世界的运行时间长？
        # bsdtime      The display format is usually "MMM:SS",
                    # but can be `shifted to the right` if the process used more
                    # than 999 minutes of cpu time??
        # time      "[天数-]时:分:秒" format.  (alias cputime).


        # START::time the command started.-- 下面两种情况，只有细微差异
        # bsdstart   If the process was started less than 24 hours ago,
                    # the output format is  " HH:MM",
                    # else it is " Mmm:SS" (where Mmm is the  three letters of the month).

        # start_time  没超过一年前:
                    # "月 日" if it was not started the same day,
                    # or "HH:MM" otherwise.

        # 笔记：
        # --User "${1:-$LOGNAME}" : 当前用户的所有process
        # 各选项在select process时，取并集， 而非交集
        # ps -a -ux | grep --invert-match grep | grep $pidN
        # --headers repeat header lines, one per page of output.

    # done
    # 加了循环报错，错了done啥的

}

# 为啥还是会搜~/.t底下？
f(){
    if [[ `pwd` == "$HOME/d" || `pwd` == "/d" ]]
    then
        # find 的路径，用$HOME, 别用~,  用双引号括起来
        find . \
        -path "/d/docker" -prune -o  \
        -path "$HOME/d/docker" -prune -o  \
        -path "$HOME/d/.t" -prune -o       \
        -path "$HOME/t" -prune -o       \
        -path "./.t" -prune -o       \
        -name "*$1*" | bat
        echo "当前路径为： ~/d"
        echo "(没进去搜的目录, 仍会输出一行 )"
    else
        # 还是别这样，万一其他路径ln -s到~/d呢
        # if [[ `pwd` == "$HOME" ]]
        # then
        #     echo "不搜 ~/d 或  /d"
        # fi

        # find 的路径，用$HOME, 别用~,  用双引号括起来
        find . \
        -path "/d/docker" -prune -o  \
        -path "$HOME/d/docker" -prune -o  \
        -path "$HOME/d" -prune -o       \
        -path "./d" -prune -o       \
        -path "$HOME/d/.t" -prune -o       \
        -path "$HOME/t" -prune -o       \
        -path "./.t" -prune -o       \
        -path "/proc" -prune -o      \
        -path "/dev" -prune -o      \
        -name "*$1*" | bat
        echo "不搜 ~/d 或  /d "
        echo "(没进去搜的目录, 仍会输出一行 )"
    fi
}


th(){ touch $1.n }

# noglob
# Filename generation (globbing) is not performed on any of the words.
# 又叫 filename generation 或者 globbing，对特殊字符 *、?、[ 和 ]进行处理，试着用对应目录下存在文件的文件名来进行补全或匹配，如果匹配失败，不会进行扩展。
## 例子
#$ ls
#test1 test2 test3
#$ echo *
#test1 test2 test3
#$ echo test?
#test1 test2 test3
#$ echo test[1-3]
#test1 test2 test3
#$ echo l*
#l*

gc(){
    if [[ -z ${ALL_PROXY} ]]; then  # -z: 看是否empty
        echo '没开代理'
    else
        echo '代理：'
        echo ${ALL_PROXY}
    fi
    echo $1 $2 $3
    git clone $1 $2
}
alias gcc='nocorrect gcc'
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
# alias git='pro &&  git'
alias globurl='noglob urlglobber '
hl(){
    du --summarize --human-readable $* | sort --human-numeric-sort --reverse| bat
 }

alias http-serve='python3 -m http.server'

# check ip
cip(){
curl --show-error --silent cip.cc 2> ~/.t/curl_cip.cc.out
OUT=`cat ~/.t/curl_cip.cc.out`
# string contain substring? shell处理字符串切片
    # string='My string';
    # if [[ $string =~ "My" ]]; then
    #     echo "It's there!"
    # fi
if [[ $OUT == *"Recv failure"* ]];then
    echo "curl cip.cc 的结果 >_> $OUT"
    unset ALL_PROXY &&  echo "\n代理挂了，切回无代理"
    INDEX=0
else

fi
# source ./apt_source.sh
# source ./apt_source.sh

}

alias k='kill -9'


alias locate='noglob locate'


alias m='\mv -iv'
alias mv='\mv -iv'
alias mm='\mv -iv -t `pwd`'
alias m.='\mv -iv -t `pwd`'


# Makes a directory and changes to it.
mcd() {
    #这么写，要放到开头才行，不然说  "done 附近有错”
    #for x in $*
    #do
        #if [ -d "${x}" ]; then
            #echo "已存在:$x"
        #else
            #\mkdir -p "$x"
        #fi
    #done

    #[[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
    #mkdir 会变成上面我自己写的md，有暂时无法解释的bug
    [[ -n "$1" ]] && \mkdir -p "$1" && builtin cd "$1"
    #-n:
#   string is not null.
}


alias pi='pip3 install'
alias pip='pip3'


alias rm='nocorrect rm -Irv --preserve-root'

# alias rsync='noglob rsync'
#
# o for open (source .zsrc,  as if opening a new zsh, to make new config take effect)
# alias o='source ~/.zshrc'  # 有时source后，alias就算在文件中被删了，还在"
alias o='zsh'  # 有时source后，alias就算在文件中被删了，还在"


alias to=htop
alias sm='htop --user=`whoami` --delay=30 --no-colour --tree'  # system monitor
alias top=htop
alias toc='htop -s %cpu'
alias tom='htop -s %mem'

alias z='_z 2>&1'


# alias oc='_oc(){ g++ $* -o ${1%.*} `pkg-config --cflags --libs opencv` ; ./${1%.*}; };_oc'
# -f指定归档文件
#  -z (同 --gzip, --gunzip, --ungzip)  通过 gzip 过滤归档
# alias -s gz='wf_gz(){ tar -xzf $* ; t $* ; };wf_gz'

alias disimg="~/dotF/imcat/imcat"
alias imcat="~/dotF/imcat/imcat"
alias -s png=imcat
alias -s jpg=imcat
alias -s jpeg=imcat
alias -s svg=imcat
alias -s bmp=imcat
alias -s gif=imcat

# -x 等同 --extrac
alias -s tar='tar -xf'

alias -s gz='tar -xzf'
alias -s bz2='tar -xjf'  # -j   针对bz2

alias -s tar.bz2='tar --extract --bzip2 --verbose -f' #-f指定文件
alias -s tbz='tar --extract --bzip2 --verbose -f' # 同上

alias -s tar.gz='tar -xzf'
alias -s tgz='tar -xzf'  # 同上

alias -s tar.xz='tar -xJf'
alias -s txz='tar -xJf'  # 同上

##加了这行导致./build_ops.sh等执行不了
#alias -s sh=vi
# 会导致执行不了?
# alias -s make='vim'

alias -s md=bat
alias -s log=bat
alias -s txt=bat
alias -s html=bat

alias -s yaml=vim
alias -s yml=vim

cj(){
    # cj: 意思是 see json
    jq -C "" $1 |le -R  # jq: json query？
}
alias -s json=cj

if [[ -n "$TMUX" ]];
then
    # zsh默认用vim打开，导致无法执行？有其他bug？但是很多人都这么写
    alias -s {cpp,txt,zsh,vim,py,toml,conf.cfg,s}=vim
    # 后缀名s表示seting,简洁,代替conf
    # alias -s py=vim  # 要是想 让python被zsh自动补全,注释掉这行
else
    alias -s {cpp,txt,zsh,vim,py,toml,conf.cfg,s}=code
fi

alias ai='sudo apt install'
alias apt='sudo apt'
alias apt-get='apt'


# unix software resoure python
# alias up='/usr/bin/python'

# 函数开头, 比如下面的echo, 前少了空格，在用这个alias时，报错zsh: parse error near `}

# http://faculty.salina.k-state.edu/tim/unix_sg/shell/variables.html
# 1. 方法名后面可以有多个空格
# 2. 括号内可以有多个空格
# 3. 括号可以不要，但是为了美观，建议加上括号
# 4. 如果方法体写成一行，需要在语句后面加分号“;”
# 5. $*表示除$0外的所有参数

#变量名=$(命令名)
#result=$(password_formula)
#
# print -Pn "\e]2;%~\a" #在terminal的tittle显示路径
#
# 获得当前路径的basename
# $PWD:t
# 或者
# basename $PWD  # 更通用

# sh -c "$(curl -fsLS git.io/chezmoi)" 意思：
# -f :Fail silently (no output at all) on HTTP error
# -s :Silent mode
# -S : Show error even when -s is used
# -L : follow redirects

alias wg='axel'
alias wget='echo "using axel. 要是遇到别人写wget -O-，知道它是重定向到stdout就好。 axel的参数和wget不同" ; axel'
alias wgname='wget -c -O "wf_need_to_change_name"'

 # sh -c "$(wget -q -O- git.io/chezmoi)"
 # -O: 指定输出文件名
 # -O-：  输出到stdout


