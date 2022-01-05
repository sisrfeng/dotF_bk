#!/bin/bash

LEO_color=16;

while [ $LEO_color -lt 245 ]; do
    # Enable interpretation of backslash 转义
    echo -e "$LEO_color: \\033[38;5;${LEO_color}m hello\\033[0m"
    echo -e "\\033[48;5;${LEO_color}mworld\\033[0m"
    ((LEO_color++));
done
