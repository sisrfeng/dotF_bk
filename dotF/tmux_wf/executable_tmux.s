# 删掉了tpm作者推荐的目录~/.tmux
# tmux的东西都在~/dotF/tmux_wf
# -g : set a global option
set -g @plugin 'tmux-plugins/tpm'

# tmux supports user options which are prefixed with a ‘@’.  User options may have any name, so long as they
# are prefixed with ‘@’, and be set to any string.  For example:
#
#         $ tmux set -g @foo "abc123"
#         $ tmux showw -v @foo  # -v: show only the option value, not the name
#         abc123


set -g @plugin 'tmux-plugins/tmux-logging'
set -g @logging-path "$HOME/d/.tmux_log_by_plugin_leo"
# set -g @screen-capture-key 'T'  #保存在home下，不受上面的控制

# [[==========================打通tmux和系统、nvim的粘贴板。反应有点慢================
set -g @plugin 'tmux-plugins/tmux-yank'  #  依赖xsel或xclip.  xsel (recommended)
set -g @yank_selection 'clipboard' # or 'secondary' or 'clipboard'
set -g @yank_selection_mouse 'clipboard' # or 'primary' or 'secondary'


# 被tmux-yank覆盖了:
# bind -T copy-mode-vi 'y' run-shell 'tmux send -X copy-end-of-line && tmux paste'

# bind -T copy-mode-vi 'yy' send -X copy-end-of-line
# bind -T copy-mode-vi 'M-j' send j5  todo 不行

bind  -T copy-mode-vi  'Y' send -X copy-end-of-line

bind -T copy-mode-vi 'H' send '^'
bind -T copy-mode-vi 'L' send '$'

bind 'a' run-shell "tmux copy-mode; tmux send k; tmux send H"

# toggle number # 不行
# bind 'v' run-shell "F2 ; tmux copy-mode; tmux send v"
bind 'v' run-shell "tmux copy-mode; tmux send 'v' ; tmux send 'c'"


bind -T copy-mode-vi 'space' send -X begin-selection
bind -T copy-mode-vi 'v'   send -X rectangle-toggle
# bind -T copy-mode-vi 'c' send -X rectangle-toggle

# 进了copy-mode后 没选中内容时, rectangle-toggl看不到生效
# bind -T copy-mode-vi 'C-v' run-shell "tmux rectangle-toggle"  # copy mode的命令不能这样, 要send -X
# todo: 现在并没有toggle
bind -T copy-mode-vi 'C-v' send -X rectangle-toggl

# 试过变成下面这行的t的 效果,后来又不会了 （正常了) 神奇

# tmux-how-to-display-line-numbers-in-copy-mode
# bind -T copy-mode-vi t  split-window -h -l 3 -b "printf '\e[38;5;0m\e[48;5;226m' && seq 500 -1 1 && echo -n 0 && read" \; selectp -l


# ==========================打通tmux和系统、nvim的粘贴板。反应有点慢================]]

# unbind 't'  待用 to use
# unbind u
unbind -T  copy-mode-vi 'Enter'
# unbind x
# unbind [
# C-r  # 留给vim
# unbind f

# -n :  no prefix needed
unbind -n 'c-s'

bind -n "C-h" previous-window
bind -n "C-l" next-window
bind 'p' last-window
bind 'n' next-layout
unbind -n p # run-shell "tmux paste"  # todo 和vim的打通



# 查看键绑定
# tmux lsk -Tcopy-mode | bat
# tmux lsk | bat

# 多个快捷键都在vscode中无效.  别在vscode里开tmux了
set -g prefix 'C-M-t'

setw -g mode-keys vi  # mode to use in copy and choice modes (vi/emacs)

set -g mouse on


# https://stackoverflow.com/a/46638561/14972148
# 把人家的xclip神器换成xsel 不行

bind -T copy-mode-vi DoubleClick1Pane \
    select-pane \; \
    send-keys -X select-word-no-clear \; \
    send-keys -X copy-pipe-no-clear "xsel --input --clipborad"
    # send-keys -X display 'copied'


    # -n: 不需要敲prefix键
    # copy-mode -M  :  begin a mouse drag
    # 在copy-mode里如何display？
bind -n DoubleClick1Pane \
    select-pane \; \
    copy-mode -M \; \
    send-keys -X select-word \; \
    send-keys -X copy-pipe-no-clear "xsel --input --secondary" \; \
    display 'copied'



bind -T copy-mode-vi TripleClick1Pane \
    select-pane \; \
    send-keys -X select-line \; \
    send-keys -X copy-pipe-no-clear "xsel -in -sel primary"
bind -n TripleClick1Pane \
    select-pane \; \
    copy-mode -M \; \
    send-keys -X select-line \; \
    send-keys -X copy-pipe-no-clear " xsel --input --nodetach  primary"

set -g focus-events on

# reload
bind 'r' source-file ~/dotF/tmux_wf/tmux.s \; display "wf tmux: reload成功"
# 分号要转义：Semi-colon is also used as a command separator in tmux

# e记作 extract
bind 'e' break-pane


bind 'c' new-window -c "#{pane_current_path}"
# bind 'Meta' new-window -c "#{pane_current_path}"  # 不行
# splitting panes
bind '\' split-window -h -c "#{pane_current_path}"
bind 'space'  split-window -c '#{pane_current_path}'
bind '-' split-window -c "#{pane_current_path}"

# bind -n C-n send-keys 'bash ~/wf/dotF/cfg/tmux/save_conda_new_pane.sh' Enter
# bind  'space' send-keys 'bash ~/wf/dotF/cfg/tmux/save_conda_new_pane.sh' Enter


# 这会导致source本tmux.s 时， 多执行split-window -c "#{pane_current_path}"
# bind 'o' kill-pane ;split-window -c "#{pane_current_path}"
# 原因：Semi-colon is also used as a command separator in tmux
bind 'o' kill-pane \; split-window -h -c "#{pane_current_path}"  # 类比zsh下敲o: open new zsh 【想删掉
# 的环境变量，在子shell中不能及时更新。改了函数，进子zsh会看到变化】

set-environment -g PATH "/usr/local/bin:/bin:/usr/bin"
# before any `run-shell` commands
# run-shell 简写为 run:  execute a command without creating a new window
# If the command doesn't return success, the exit status is also displayed.

# Pane之间切换的快捷键
bind 'h' selectp -L                       # 定位到左边窗口的快捷键
bind 'j' selectp -D                       #
bind 'l' selectp -R                       #
bind 'k' selectp -U                       #


bind -T copy-mode-vi 0 send -X start-of-line
bind -T copy-mode-vi : command-prompt -p "(跳到第几行？行1在最底 : )" "send -X goto-line \"%%%\""

# 上下左右:
# ^[[1;5A^[[1;5B^[[1;5D^[[1;5C

# tmux还没map 'C-,'  在windows terminal下 不知道为啥变成ctrl l


# -g: global session option,
# -a append to string options
# -s:   change server(not session) options

# If you're using screen or tmux,
    # TERM should be screen-256color (Not xterm-256color)  tmux-256color 兼容了screen-256color ?

# set -g terminal-overrides ",xterm*:xterm-256color,wf_something:linux":
#                            TERM=xterm would be interpreted as TERM=xterm-256color
#                            and TERM=wf_something →  TERM=linux  ?

# set -g defaulr-terminal "tmux-256color"


# https://unix.stackexchange.com/a/568263/457327
# `default-terminal` :
# for TERM inside tmux,
# tells applications inside tmux:  what the capabilities are for tmux itself.

# `terminal-overrides`
# for TERM `outside` tmux
# allows you to modify the capabilities tmux uses,  when it talks to the terminal it is running it??
# 改它：terminal descriptions read using terminfo


# nvim教的：  解决 <Home> or some other "special" key doesn't work
set -g default-terminal "screen-256color"
#  Set the default terminal for new windows created in this session , 换言之:
# the default value of the TERM environment variable.
# For tmux to work correctly,  this must be set to ‘screen’, ‘tmux’ or a derivative of them.


# https://gist.github.com/bbqtd/a4ac060d6f6b9ea6fe3aabe735aa9d95
# The screen-256color in most cases is enough and more portable solution.
# But it does not support any italic font style.

# set -g default-terminal "tmux-256color"  # 先别用, 因为
# Unfortunately, The latest (6.2) ncurses version does not work properly


# `terminal-overrides`  格式：
# For example, to set the ‘clear’ terminfo(5) entry to ‘\e[H\e[2J’ for all terminal types matching ‘rxvt*’:
    # rxvt*:clear=\e[H\e[2J
    # 终端类型:名字=值
    # rxvt*中， 星号表示通配

set -g -a terminal-overrides ',*256col*:Tc'
# 解决nvim的Cursor shape doesn't change in tmux
set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'





# -N: 放到buffer? starts without the preview.  This command works only if at least one client is attached
# todo: 把prompt去掉
bind -T copy-mode-vi 1                 command-prompt -N -I 1  "send -N \"%%%\""
bind -T copy-mode-vi 2                 command-prompt -N -I 2  "send -N \"%%%\""
bind -T copy-mode-vi 3                 command-prompt -N -I 3  "send -N \"%%%\""
bind -T copy-mode-vi 4                 command-prompt -N -I 4  "send -N \"%%%\""
bind -T copy-mode-vi 5                 command-prompt -N -I 5  "send -N \"%%%\""
bind -T copy-mode-vi 6                 command-prompt -N -I 6  "send -N \"%%%\""
bind -T copy-mode-vi 7                 command-prompt -N -I 7  "send -N \"%%%\""
bind -T copy-mode-vi 8                 command-prompt -N -I 8  "send -N \"%%%\""
bind -T copy-mode-vi 9                 command-prompt -N -I 9  "send -N \"%%%\""

#  分号被autohotkey改了，输入不了真正的分号
# bind -T copy-mode-vi '\;' send -X jump-again


set -g pane-border-status top
# set -g pane-border-format "#{pane_index} #{pane_current_command} #P #T"
# set -g pane-border-format "#T"
set -g pane-border-format ""  # 在vim里显示文件名，别再显示这个了
set -g pane-active-border-style fg=black,bg=colour7
set -g pane-border-style fg=colour108
# set -g pane-border-style 'fg=#123456,bg=default'


#  没有pane-style
# set -g pane-style 'fg=#123456,bg=default'
# set -g pane-active-style 'fg=default,bg=default'   # terminal的white不是000000，两个white叠在一起，背景变得更暗

# 符号 代码 代号 变量 的含义
#   # A literal `#’
#   S Session name
#   H Hostname of local host
#   h Hostname of local host without the domain name

#   F Current window flag
#   I Current window index
#   T Current window title  用于pane的设置时	pane title
#   W Current window name

#P Current pane index
#D	pane id

#(date)	shell command


#logging: 还没试
#set-hook -g 'after-new-pane' 'run-shell "pipe-pane -o 'cat >>~/output.#S:#I-#P'"'
set -g default-shell /bin/zsh



# 问号要转义
# 从底部往上搜
bind 'f' run-shell 'tmux copy-mode; tmux send "?"'
# bind f run-shell "tmux copy-mode; tmux send /"

# 改了tmux.s, 有时要退出session后才生效
# 按了prefix, 再?   ,  看现在的bind

#"bind" is an alias for "bind-key", "bind-k" "bin"等开头缩写同理, 只要不引起系统误会
#set-option即set
#set-window-option即setw




# 学习怎么用prompt提示
# bind s command-prompt -p "send pane to:"  "join-pane -t '%%'"  #会报错...





# tmux-how-to-display-line-numbers-in-copy-mode
# bind -T copy-mode-vi = split-window -h -p 90 'seq 24 -1 1;sleep 15'
bind -T copy-mode-vi t  split-window -h -l 3 -b "printf '\e[38;5;0m\e[48;5;226m' && seq 500 -1 1 && echo -n 0 && read" \; selectp -l

bind _ run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-horizontal -p 80" # main-pane的尺寸占整个窗口的比例
bind | run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-vertical -p 80"

# with modern computers it is ok to set this option to a high number.
set -g history-limit 50000

# status bar
# 少了-g的话,开了新session会报no target
set -g status on
set -g status-keys vi # status bar的键位
set -g status-left-length 50


set -g status-left "  #S  |  #[fg=green,dim] #[bg=dim]#h "  #   会话:#S"

# execute a tmux command if a shell-command succeeded
# if-shell '[[ -z "$SSH_CLIENT" ]]' \   用[[不行, 要用[
# if-shell "[ $HOST == 'redmi14-leo' ]"  这个为啥不行？
if-shell '[ -z "$SSH_CLIENT" ]' \
    'set -g status-left "#S #[fg=green,dim] 本地#[bg=yellow]#h "  '
    # 'source-file ~/.tmux.remote.conf'


set -g status-right "#[fg=red,dim]   %m月%d %H:%M "
set -g status-justify "centre"

set -g status-right-length 40
# dim让颜色没那么抢眼
# set -g status-right '#[fg=red,dim]%d号 %H:%M #(echo ${CONDA_PROMPT_MODIFIER})'     #
# 这样不会跟着pane的变化而变。todo
# set -g status-bg white,dim
set -g status-style bg=white

# set -g status-left-bg  white
# set -g status-left-fg '#2EaE2E'

if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 2\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g status-utf8 on'


# -r：repeat. 避免老是要按prefix
bind -r C-h resizep -L
bind -r C-j resizep -D
bind -r C-k resizep -U
bind -r C-l resizep -R

bind -n C-q resizep -R

# 设置window属性
set -g renumber-windows on



# status bar updates every 15s by default**, change to 1s here
# a lower latency might have negative battery/cpu usage impacts)
set -g status-interval 5


# setw -g window-status-format "#I.#{window_current_command}:#T》"  #T - current pane title
set -g window-status-format '#I’ #(pwd="#{pane_current_path}"; echo ${pwd####*/})  '
set -g window-status-current-style fg=colour208,bg=default
set -g window-status-current-format '#F #I’ #(pwd="#{pane_current_path}"; echo ${pwd####*/})'  # 这里用单引号 会不生效
#   #F 显示这些flag
#   *         Denotes the current window.
#   -         Marks the last window (previously selected).
#   #         Window is monitored and activity has been detected.
#   !         A bell has occurred in the window.
#   ~         The window has been silent for the monitor-silence interval.
#   M         The window contains the marked pane.
#   Z         The window's active pane is zoomed.


# 此类配置可以在命令行模式中输入show-options -g查询
set -g display-time 3000                   # 提示信息的持续时间；设置足够的时间以避免看不清提示，单位为毫秒
set -g repeat-time 500                    # 控制台激活后的持续时间；设置合适的时间以避免每次操作都要先激活控制台，单位为毫秒




# 此类设置可以在命令行模式中输入show-window-options -g查询
# Start Window Numbering at 1
set -g base-index 1
setw -g pane-base-index 1

bind 'q' "kill-pane" # 使用q来关闭窗口 kill-pane必须加引号



set -s escape-time 0  # Allows for faster key repetition
# setw -g monitor-activity on  # 非活动窗口的任务完成后会变黑，干扰
# set -g visual-activity on  #这行会导致已有动静就弹窗，别加


# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.s)
 # ~/dotF/cfg/tmux/plugins/tpm/tpm  软连接到了：
run-shell '~/dotF/tmux_wf/plugins/tpm/tpm'

