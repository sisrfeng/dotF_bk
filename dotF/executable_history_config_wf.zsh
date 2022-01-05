#setopt prompt_subst

# HISTTIMEFORMAT is for bash, 别用
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# .zsh_history的内容格式：
# : 1471766804:3;git push origin master
# 3表示3秒

# 3选一：
# setopt SHARE_HISTORY             # Share history between all sessions.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY_TIME   # 上面一行。使得记录的elapsed time准确

# 不行：
# if [[ -f "$HOME/.zsh_history" ]]  # -f:  regular fie
# then
    # HISTFILE="$HOME/.zsh_history"
# else
    # HISTFILE="$HOME/.history_zsh"
# fi

export HISTFILE="$HOME/.zsh_history"

export HISTSIZE=1000000   # the number of items for the internal history list (一个zsh session自己的历史)
export SAVEHIST=1000000   # maximum number of items for the history file


# 设了这个，不利于回顾历史 反思总结
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
# setopt HIST_IGNORE_DUPS          # Do not enter command lines into the history list if they are duplicates of the previous even
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.

setopt HIST_FIND_NO_DUPS         # When searching for history entries in the line editor,
                                    # do not display duplicates of a line previously found,
                                    # even if the duplicates are not contiguous.

# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space. 用途：有些命令不想记录，就在前面加个空格。但开了这个，有可能不小心就漏掉某些历史
                                   # If you want to make 之前的命令 vanish right away without entering another command, type a  space  and  press  return.
# 有的地方教人用下面这个小写的，但貌似官方的说明里，没有它。是bash的？
# setopt histignorespace           # skip cmds w/ leading space from history

# 导致多行输入变单行，加\n  ？
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
