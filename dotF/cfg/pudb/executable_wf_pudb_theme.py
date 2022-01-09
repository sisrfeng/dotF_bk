#!/usr/bin/env python
# -*- coding: utf-8 -*-



# Note, be sure to test your theme in both curses and raw mode (see the bottom
# of the preferences window).
#  Curses mode will be used with screen or tmux.



palette.update({
    #  "source": (add_setting("black", "underline"), "dark green"),

    #  "setting_name": (foreground_color, background_color),
    # 256 color chart: http://en.wikipedia.org/wiki/File:Xterm_color_chart.png

    # UI
    "header": ( "black", "h231"),
    "focused sidebar": ("white", "h249"),
    "group head": ("black", "h249"),
    "background": ("black", "h249"),
    "label": ("black", "h249"),
    "value": ("white", "dark blue"),
    "fixed value": ("black", "h249"),

    "variables": ("h249", "default"),

    "var label": ("dark blue", "default"),
    "var value": ("h249", "default"),

    "focused var label": ("white", "dark blue"),
    "focused var value": ("black", "h159"),

    "highlighted var label": ("white", "light green"),
    "highlighted var value": ("white", "light green"),
    "focused highlighted var label": ("white", "light green"),
    "focused highlighted var value": ("white", "light green"),

    ##########  stack
    "stack": ("h249", "default"),

    "frame name": ("dark blue", "default"),
    "frame class": ("h249", "default"),
    "frame location": ("light green", "default"),

    "focused frame name": ("white", "dark blue"),
    "focused frame class": ("black", "h159"),
    "focused frame location": ("dark gray", "h159"),

    "focused current frame name": ("white", "light green"),
    "focused current frame class": ("black", "h109"),
    "focused current frame location": ("dark gray", "h109"),

    "current frame name": ("white", "h109"),
    "current frame class": ("h0", "h109"),
    "current frame location": ("h235", "h109"),

#下面进行了批量替换:  %s/light blue/h237/gc


     # breakpoints
    "breakpoint": ("h237", "default"),
    "disabled breakpoint": ("light gray", "default"),
    "focused breakpoint": ("white", "light green"),
    "focused disabled breakpoint": ("light gray", "h109"),
    "current breakpoint": ("white", "dark blue"),
    "disabled current breakpoint": ("light gray", "h159"),
    "focused current breakpoint": ("white", "light green"),
    "focused disabled current breakpoint": ("light gray", "h109"),

    # source
    "breakpoint source": ("h0", "h224"),
    "current breakpoint source": ("h22","h224"),
    "breakpoint focused source": ("h23", "h224"),
    "current breakpoint focused source": ("h24", "h224"),

    "breakpoint marker": ("dark red", "default"),

    "search box": ("default", "default"),

    "source": ("h235", "default"),
    "current source": ( "h237","h255"),
    "current focused source": ("h0", "h181"),

    "focused source": ("h0", "h153"),

    "current highlighted source": ("black", "h195"),
    "highlighted source": ("h237", "black"),

    "line number": ("h237", "default"),
    "keyword": ("dark green", "default"),
    "name": ("h237", "default"),
    "literal": ("dark cyan", "default"),
    "string": ("dark cyan", "default"),
    "doublestring": ("dark cyan", "default"),
    "singlestring": ("h237", "default"),
    "docstring": ("dark cyan", "default"),
    "backtick": ("light green", "default"),
    "punctuation": ("h237", "default"),
    "comment": ("h130", "default"),
    "classname": ("dark blue", "default"),
    "funcname": ("dark blue", "default"),

    # shell
    "command line edit": ("h237", "default"),
    "command line prompt": ("h237", "default"),

    "command line output": ("h237", "default"),
    "command line input": ("h237", "default"),
    "command line error": ("dark red", "default"),

    "focused command line output": ("black", "h109"),
    "focused command line input": ("black", "h109"),
    "focused command line error": ("dark red", "h255"),

    "command line clear button": ("h237", "default"),
    "command line focused button": ("black", "h237"),
    })
