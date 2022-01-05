# 改了这文件，要新开zsh才生效
#[[[--------------------------------less color-------------------------------------

# termcap(被淘汰了) terminfo
# ks                smkx      make the keypad send commands
# ke                rmkx      make the keypad send digits

# vb                flash     emit visual bell
# mb                blink     start blink
# me                sgr0      # turn off bold, blink and underline
# so                smso      start standout (reverse video)
# se                rmso      stop standout
# us                smul      start underline
# ue                rmul      stop underline

export LESS_TERMCAP_md=$(tput bold; tput setaf 22) # Stop bold effect.
export LESS_TERMCAP_me=$(tput sgr0)  # turn off bold, blink and underline


# export LESS_TERMCAP_so=$(tput bold; tput setaf "#ff0000";   # 只支持256色
# 更新:
# todo
# Terminfo has supported the 24-bit TrueColor capability since ncurses-6.0-20180121, under the name "RGB".
# You need to use the "setaf" and "setab" commands to set the foreground and background respectively.

export LESS_TERMCAP_so=$(tput bold; tput setaf 37; tput setab 255)  # stand-out (reverse text).
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # Stop stand-out effect  和下面这行效果一样？


export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 54) # Underline effect Start
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)  # Stop underline effect.

# todo 有些蓝色字后面的字是灰的 dim？
# 不知道是啥：
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export LESS_TERMCAP_ZN=$(tput ssubm)
# export LESS_TERMCAP_ZV=$(tput rsubm)
# export LESS_TERMCAP_ZO=$(tput ssupm)
# export LESS_TERMCAP_ZW=$(tput rsupm)
# export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal
