import warnings
warnings.filterwarnings('ignore')
from time import perf_counter as dida
dida0 = dida()

import sys, os
sys.path.append(os.path.expanduser ('~/dotF') )
from wf_snippet import vpp as print


import torch
from torch.utils.data import DataLoader
from torch.utils.tensorboard import SummaryWriter

import time


from loguru import logger
log_file = args.exp_name + '/my.log'
os.system('mv -f {}  {}_bk'.format(log_file, log_file))
logger.add(log_file)
logger.info(str(vars(args)))


import os
def find_gpus(num_of_cards_needed=6):
    os.system('nvidia-smi -q -d Memory |grep -A4 GPU|grep Free >~/.tmp_free_gpus')
    # If there is no ~ in the path, return the path unchanged
    with open(os.path.expanduser ('~/.tmp_free_gpus'), 'r') as lines_txt:
        frees = lines_txt.readlines()
        idx_freeMemory_pair = [ (idx, int(x.split()[2]))
                                for idx, x in enumerate(frees) ]
    idx_freeMemory_pair.sort(reverse=True)  # 0号卡经常有人抢，让最后一张卡在下面的sort中优先
    idx_freeMemory_pair.sort(key=lambda my_tuple: my_tuple[1], reverse=True)
    usingGPUs = [str(idx_memory_pair[0]) for idx_memory_pair in
                    idx_freeMemory_pair[:num_of_cards_needed] ]
    usingGPUs = ','.join(usingGPUs)
    for pair in idx_freeMemory_pair[:num_of_cards_needed]:
        print('{}号: {} MB free'.format(*pair) )
    return usingGPUs


os.environ['CUDA_VISIBLE_DEVICES'] = find_gpus(1)  # 必须在import torch前面
import torch
# XPU: CPU or GPU
myXPU = torch.device('cuda')   # ('cuda:号数')   号数:从0到N, N是VISIBLE显卡的数量。号数默认是0 [不是显卡的真实编号]