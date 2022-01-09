wf_use_function_as_block_comment_color () {
00=none #和0一样？
01=bold
04=underscore
05=blink
07=reverse
08=concealed 隐藏

颜色表
Foreground:
30 - black
31 - red
32 - green
33 - yellow
34 - blue
35 - magenta
36 - cyan
37 - white

Background:
40 - black
41 - red
42 - green
43 - yellow
44 - blue
45 - magenta
46 - cyan
47 - white

CAPABILITY 30;41 # file with capability
OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable

“\e” :  escape sequence.
“m”  :end of the command. 记作mark吧

\033[ 必须有。0是消除之前的设置 m或者M代表作用与文本，且在这里结束
black   = '\033[0;30M'
red     = '\033[0;31M'
green   = '\033[0;32M'
yellow  = '\033[0;33M'
blue    = '\033[0;34M'
magenta = '\033[0;35M'
cyan    = '\033[0;36M'
white   = '\033[0;37M'

; 给上面的颜色加粗而已
bright_black   = grey = '\033[1;30M'
bright_red     = '\033[1;31M'

black_background   = '\033[40M'

}