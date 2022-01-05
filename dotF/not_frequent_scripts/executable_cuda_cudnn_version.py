#使用 PyTorch 查看 CUDA 和 cuDNN 版本

import torch
print(torch.__version__)
print(torch.version.cuda)
print(torch.backends.cudnn.version())