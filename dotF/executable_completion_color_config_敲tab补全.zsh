
# todo
# 好像值得学习
# https://unix.stackexchange.com/questions/27236/zsh-autocomplete-ls-command-with-directories-only


#自动补全功能
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE #开启此选项，补全时会直接选中菜单项

# ':completion:<function>:<completer>:<command>:<argument>:<tag>'
# tag : a type of match. 常见tags “files”, “domains”, “users”`用户自定义？`, or “options”
#  即： information displayed during completion

# ------删掉好像没变化
##彩色补全菜单
# eval $(dircolors -b)
# export ZLSCOLORS="${LS_COLORS}"
# ------删掉好像没变化

# echo $LS_COLORS    得到：
# :ex=00:no=0:*.csv=00:*.txt=0:fi=47;30:di=30:tw=34;4:ow=34;4:ln=34;4:or=01;05;31:
# *.md=30;47:*.py=47;33:*.vim=34:*.json=36;47:*.swp=00;44;37:*.c=1;33:*.C=1;33:*.h=1;33:*.jpg=1;32:*.jpeg=1;32

# 来自https://github.com/trapd00r/LS_COLORS

# ZLSCOLORS 内容比 LS_COLORS多很多

zmodload zsh/complist

setopt MENU_COMPLETE
setopt LIST_ROWS_FIRST
setopt LIST_PACKED  # 排得更紧凑
# setopt AUTO_MENU   # 加不加好像都一样
# CTRL+x i
# bindkey -M menuselect '^xi' vi-insert


# [[==================================================================================按tab自动补全的东西的颜色
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# (s.:.) 作用是把 这长串的冒号去掉 :ex=00:no=0:*.csv=00:*.txt=0:
# (s.e.)  去掉e   regex?  /s/e/
# 就此打住

zstyle ':completion:*'                          list-colors '=*=0'     #   如果不加这行，可能之前的配置留下了编译后的文件，导致不想要的老效果还留着
zstyle ':completion:*:commands'                 list-colors '=*=32'
zstyle ':completion:*:options'                  list-colors '=^(| *)=34'     # `^` 表示取反  * 表示任意

# zstyle ':completion:*:*:kill:*'                 list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'
zstyle ':completion:*:*:kill:*:processes'       list-colors '=(#b) #([0-9]#)*=0=01;31'

# zstyle ':completion:*:aliases'                list-colors '=*=2;38;5;128'
# zstyle ':completion:*:builtins'                 list-colors '=*=38;5;142'

# zstyle ':completion:*:parameters'               list-colors '=*=32'
#
# ==================================================================================按tab自动补全的东西的颜色 ]]

zstyle ':completion:*' list-separator '|'
zstyle ':completion:*' file-list false  # 太啰嗦


##[[------------------------过滤external-command---------------------
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
##加了没变化:
# zstyle ':completion:*:*:-command-:*' group-order 'alias external-command local-directories'
# zstyle ':completion:*:*:-command-:*' group-order local-directories
zstyle ':completion:*:*:-command-:*:*' group-order alias functions commands builtins  #` -command- means any word in the “command position”. ` 没懂

##加了没变化:
#zstyle ':completion:*:*:-command-:*' ignored-patterns 'external-command'

zstyle ':completion:*:complete:-command-:*:*' tag-order 'external-command' 'local-directories'  # 多个单引号引住的内容，有顺序/优先级：最考前的优先冒出来

##----------------------过滤external-command---------------------]]


zstyle ':completion:*:*sh:*:' tag-order files

zstyle ':completion:*:*:*:*:descriptions' format $'\e[01;33m %d \e[0m'  # 表示补全类型:   %d
zstyle ':completion:*:(approximate|correct)' format ' %F{yellow}近似__校正_%d for %o (errors: %e)%f'
zstyle ':completion:*:*expansions' format ' %F{cyan}扩展_%d for %o%f'
zstyle ':completion:*:warnings' format $'\e[01;31m 无法补全 \e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m 补全信息 %d --\e[0m'
zstyle ':completion:*:*:*:*:corrections' format $'\e[38;2;10;230;10m 校正 (错误字数: %e) \e[0m'   #  [38;2;{r};{g};{b}m  真彩色 true colors
# zstyle ':completion:*:*:*:*:corrections' format $'\e[32m 校正 (错误字数: %e) \e[0m'

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# =[[====================================参考=======================================begin]]
# %B (%b)
# Start (stop) boldface mode.

# %E
# Clear to end of line.

# %U (%u)
# Start (stop) underline mode.

# %S (%s)
# Start (stop) standout mode.

# %F (%f)
# Start (stop) using a different `f`oreground colour, if supported by the terminal. The colour may be specified two ways: either as a numeric argument, as normal, or by a sequence in braces following the %F, for example %F{red}. In the latter case the values allowed are as described for the fg zle_highlight attribute; Character Highlighting. This means that numeric colours are allowed in the second format also.

# Start (stop) using a different bac`K`ground colour. The syntax is identical to that for %F and %f.

# %{...%}
# Include a string as a literal escape sequence. The string within the braces should not change the cursor position. Brace pairs can nest.

# A positive numeric argument between the % and the { is treated as described for %G below.

# %G
# =[[====================================参考=======================================end]]


zstyle ':completion::complete:*' use-cache on
# todo  为什么试了几次， 还是没东西写进这文件？
# zstyle ':completion::complete:*' cache-path "$HOME/.completion_cache_wf.zsh"
zstyle ':completion:*' cache-path "$HOME/.completion_cache_wf.zsh"

zstyle ':completion:*:cd:*' ignore-parents parent pwd


zstyle ':completion:*:default' select-prompt '第 %m '  # %S：standout mode
zstyle ':completion:*:default' list-prompt '%S%m 不知道什么时候生效 matches | line %l | %p%s'
# zstyle ':completion:*:default' select-prompt '%S%m matches | line %l | %p%s'
# zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
#zstyle ':completion:*:match:*' original only
#zstyle ':completion::prefix-1:*' completer _complete
#zstyle ':completion:predict:*' completer _complete
#zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

##路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
#zstyle ':completion::complete:*' '\\'


##修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
##错误校正
zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 4 numeric

##kill 命令补全
#compdef pkill=kill
#compdef pkill=killall
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

##补全类型提示分组
