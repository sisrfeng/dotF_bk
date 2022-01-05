
PATH="/usr/local/cuda-10.2/bin:$PATH"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda-10.2/lib64/"
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/cuda-10.2/lib64"



source ~/dotF/rc.zsh

# 没有x11时, 不启用复制功能
# alias w='_w(){ less $1 ;};_w'

# dai li
alias dl='export ALL_PROXY=socks5://你的ip：端口'


# https://void-shana.moe/linux/customize-your-zsh-prompt.html
# 放文件开头时，颜色时有时无
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html#Prompt-Expansion
export PS1="%{$fg[cyan]%}请出入你的本地信息 %~ "$'\n'">%{$reset_color%}"
export RPS1="%{$fg[cyan]%}%T_周%w号 %{$reset_color%}"
export PS2="%{$fg[cyan]%}%_>%{$reset_color%}"
export RPS2="%{$fg[cyan]%} 换行后继续敲  %{$reset_color%}"
# 别加$bg[white]:
# export RPS2="%{$fg[cyan]$bg[white]%} 换行后继续敲  %{$reset_color%}"

export PAGER=less
export PATH

# https://github.com/pydata/numexpr/issues/322
# export NUMEXPR_MAX_THREADS=320 # 80 cpu cores x 4threds

export PYTHONPATH=
