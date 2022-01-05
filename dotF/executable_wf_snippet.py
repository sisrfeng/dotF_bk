# -*- coding: utf-8 -*-
import cv2
import numpy as np
import json
import sys
import os
import matplotlib.pyplot as plt

def cv2p(wf_img):
    wf_img = img3[..., ::-1]
    plt.imshow(img3); plt.show()

import inspect, re
import sys
from termcolor import cprint

from rich import print
#  print("[bold magenta] Hello  World [/bold magenta]" )

'''
cprint('Hello, World!', 'red', 'on_cyan')
cprint("Attention!", 'red', attrs=['bold'], file=sys.stderr)

for i in range(10):
    cprint(i, 'magenta', end='分隔线 ')

'''

def vpp_single(arg, leo_end='\n'):
    if type(arg) in [float, np.float64, np.float32]:
        arg_abs = abs(arg)
        if arg_abs < 0.001:  # [0, 1e-3]
        # if  True:  # abs > 1e-3时，有时用科学计数法反而更麻烦，要自己去数进位
            print(('%.2e'%arg).split('e')[0],  end='_')
            cprint(('%.2e'%arg).split('e')[1], 'white', 'on_cyan')
        else:
            if arg_abs<1: # [0.001 - 1)
                print(round(arg,5)) #  比如：0.001011 变成0.00101
            elif arg_abs<100:
                print(round(arg,3)) #[1,100)
            else: # [100, 很大)
                vpp_single(int(round(arg,0))) #见下方

    elif type(arg) in [int,np.int16, np.int8]:
        if abs(arg)>9999:
            print(('%.2e'%arg).split('e')[0],end='_')
            cprint(('%.2e'%arg).split('e')[1][0], 'white', 'on_red',end='') #  10的指数的正负号
            cprint(int(('%.2e'%arg).split('e')[1][1:]), 'white', 'on_red')
        else:
            print(arg)

    elif type(arg)==str:
        # print('"', arg, '"', sep='')
        print(arg, end=leo_end)
    else:
        #  太复杂的情况，不好处理
        print(arg)

#  very pretty print
def vpp(*args, end='\n'): #这里的end，到了vpp_single就叫leo—_end

    #  I want to know the variable name which is being printed
    #  but fail...
    # for line in inspect.getframeinfo(inspect.currentframe().f_back)[3]:
        # m = re.search(r'\bvpp\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)', line)
    # if m:
        # print('||》', m.group(1), end=': ')
    # todo  try this:
    # To create a dynamic variable in Python, use a dictionary.
    # name = 'number'
    # value = 10
    # variables = {name: value}
    # print(variables['number'])

    # args是一个tuple，vpp()时，args为空tuple，()
    if args  == ():
        print()

    for arg in args:
        if type(arg) in [int, float,str,np.float64, np.int8,np.int16]:
            vpp_single(arg, end)
        elif type(arg)==np.array:
            print('该array的形状是:',arg.shape)
        elif type(arg) == bool:
            print(arg)
        else: #  list tuple set
            if len(arg) < 1: # 空的'' {} ()
                print(arg)
            else:
                if type(arg) == tuple:
                    print('>>元组')
                    for i in range(len(arg)):
                        cprint('[{}]'.format(i), 'blue', end='')
                        print('  (',end='')
                        vpp(arg[i])

                if type(arg) == list:
                    print('>>列表')
                    for i in range(len(arg)):
                        cprint('[{}]'.format(i), 'blue', end='')
                        print(' →[ ',end='')
                        vpp(arg[i])

                if type(arg) == set:
                    # print('>>集合,转为list:')
                    print('>>集合')
                    arg=list(arg)
                    for i in range(len(arg)):
                        cprint('[{}]'.format(i), 'blue', end='')
                        print(' { ',end='')
                        vpp(arg[i])

                if type(arg)==dict:
                    print('>> 字典')
                    for k,v in arg.items():
                        cprint('[{}]'.format(k), 'blue', end='')
                        print(' { ',end='')
                        vpp(v)
            print('')

'''
import logging
#声明了一个 Logger 对象
logger = logging.getLogger('wf_logger_name')
import sys
logger.setLevel(logging.DEBUG)
# 创建一个流处理器handler并将其日志级别设置为DEBUG
handler = logging.FileHandler('./wf.log', mode='w', encoding=None, delay=False)
#  handler.setLevel(logging.CRITICAL)  ; handler.setFormatter( logging.Formatter(fmt='%(asctime)s - %(name)s - %(levelname)s - %(message)s', datefmt='Day_%d %H:%M:%S') )
handler.setLevel(logging.CRITICAL)  ; handler.setFormatter( logging.Formatter(fmt='[%(asctime)s] - %(message)s', datefmt='Day_%d %H:%M:%S') )
logger.addHandler(handler)
logger.critical('BEST_FOLD_NUM_PE: %d'%(123))
'''
