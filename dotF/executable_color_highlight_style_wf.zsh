# [[===========================插件 zsh-syntax-highlighting的syntax color definition====================================begin
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_STYLES


# 这里不是css的方式：
# CSS 里:
# 颜色值可以用#FFFFFF的方式表示, 对于rrggbb格式的颜色值可以用#rgb格式的简写表示.
# 不够6位的颜色值按 rgb=rrggbb的方式,自动扩展成6位颜色值
# 比如
# FFFFFF = #FFF  #00000 = #000

# 用的应该是256色的编号

ZSH_HIGHLIGHT_STYLES[command]=fg=yellow

# 左右两边同时开了个zsh，一个紫色 一个蓝色..
ZSH_HIGHLIGHT_STYLES[alias]=fg=33       # 蓝色  # 这里用的是xterm-256的颜色编号？
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=33,underline
# ZSH_HIGHLIGHT_STYLES[global-alias]=fg=cyan # global-alias有点危险，别用
ZSH_HIGHLIGHT_STYLES[function]=fg=247,bold  # 假如一个function名叫wf_func,要有_wf_func放在$fpath下，才能自动补全

ZSH_HIGHLIGHT_STYLES[path]=fg=110,underline,bold
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=yellow,standout # 不能识别的东西
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=33,standout  #  比如敲export
# ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
# ZSH_HIGHLIGHT_STYLES[command-substitution]=magenta

# ZSH_HIGHLIGHT_STYLES[assign]=111,bold 没变

# ZSH_HIGHLIGHT_STYLES[default]=none
# ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
# ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
# ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009

# ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]:=none
# ZSH_HIGHLIGHT_STYLES[autodirectory]:=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[path]:=underline
# ZSH_HIGHLIGHT_STYLES[path_pathseparator]:=
# ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]:=
# ZSH_HIGHLIGHT_STYLES[globbing]:=fg=blue
# ZSH_HIGHLIGHT_STYLES[history-expansion]:=fg=blue
# ZSH_HIGHLIGHT_STYLES[process-substitution]:=none
# ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]:=fg=magenta
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]:=none
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]:=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]:=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]:=fg=magenta
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[rc-quote]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]:=fg=cyan
# ZSH_HIGHLIGHT_STYLES[assign]:=none
# ZSH_HIGHLIGHT_STYLES[redirection]:=fg=yellow
# ZSH_HIGHLIGHT_STYLES[comment]:=fg=black,bold
# ZSH_HIGHLIGHT_STYLES[named-fd]:=none
# ZSH_HIGHLIGHT_STYLES[numeric-fd]:=none
# ZSH_HIGHLIGHT_STYLES[arg0]:=fg=green
# ===========================插件 zsh-syntax-highlighting的syntax color definition====================================]]
