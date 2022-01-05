#!/usr/bin/env python
# encoding: utf-8
# -*- coding: utf-8 -*-

from prompt_toolkit.styles import style_from_dict
from IPython.terminal.prompts import Prompts, Token
from IPython import get_ipython

style = style_from_dict({
    Token.User: '#f8ea6c',
    Token.Path_1: '#f08d24',
    Token.Path_2: '#67f72f',
    Token.Git_branch: '#1cafce',
    Token.Pound: '#000',
})

class MyPrompt(Prompts):
    def in_prompt_tokens(self, cli=None):
        return [
            (Token.User, 'kavi '),
            (Token.Path_1, '/home'),
            (Token.Path_2, '/kavi'),
            (Token.Git_branch, ' master '),
            (Token.Dollar, '$ '),
        ]

ipython = get_ipython()
ipython.prompts = MyPrompt(ipython)
ipython._style = style