set -x
mkdir -p /etc/apt/

mv /etc/apt/sources.list /etc/apt/sources.list.origin_useless
string=`cat /etc/issue`
if [[ $string =~ "Ubuntu 18" ]]  # regex
then
	cp -rf auto_install/sources_china_ubuntu18.py /etc/apt/sources.list
fi

if [[ $string =~ "Ubuntu 20" ]]  # regex
then
	cp -rf auto_install/sources_china_ubuntu20.py /etc/apt/sources.list
fi


# export ALL_PROXY=socks5://你的ip:端口
echo  'ALL_PROXY is:  ------------------begin'
echo  $ALL_PROXY
echo  'ALL_PROXY is:  -------------------end'

mv ~/.pip  ~/.pip_wf_bk
ln -s ~/dotF/.pip/ ~/

# ln -s ~/d/dotF ~/


cat ./auto_install/git_url.txt>>/etc/hosts
#### Ubuntu uses network-manager instead of the traditional Linux networking model. so you should restart the network-manager service instead of the network service
# /etc/rc.d/init.d/network restart
service network-manager restart

shopt -s  expand_aliases
# alias apt='apt -y -qq'
alias apt='apt -y -q'
alias pip='\pip3 -qq'
alias pip3='\pip3 -qq'
alias cp='cp -r'

\mkdir -p $HOME/.local/bin
touch "$HOME/.z" # 这是zsh的z跳转的记录文件

# upgrade可能把别人容器的依赖关系破坏了
# yes | (apt update && apt upgrade ; apt install  nscd )
yes | (apt update ; apt install  nscd )
/etc/init.d/nscd restart

ln -s ~/dotF/cfg/.condarc ~/
mkdir ~/.ssh
ln -s ~/dotF/cfg/.ssh/config ~/.ssh/config

[[ -d /d ]] && ln -s /d ~/d

yes | unminimize
yes | (apt install software-properties-common)  # software-properties-common提供了这个bin：  add-apt-repository
yes | (add-apt-repository ppa:ultradvorka/ppa )
yes | (add-apt-repository ppa:deadsnakes/ppa && apt -qq update )
yes | (apt install sudo)  # 仅限于容器内用root。容器外，没sudo别乱搞
alias ai='sudo apt install -y -qq'

ai libatlas-base-dev  gfortran libopenblas-dev liblapack-dev
ai python3.9
ai python3.9-distutils

yes | (ai man bat)
ln -s /usr/bin/batcat /usr/local/bin/bat

yes | (ai aptitude ;aptitude update -q ; ai zsh; ai progress; ai libevent-dev)
yes | (ai htop ;ai ack ;ai axel; ai intltool; ai tmux ; ai fontconfig; ai xdg-utils)
yes | (ai exiftool htop tree tzdata locales)
yes | (ai ctags; ai build-essential; ai cmake; ai python-dev)
yes | (ai curl  ffmpeg libsm6 libxext6)
yes | (ai python3-setuptools ;  ai xsel)
yes | (ai rename wget  tldr)

# yes | (mutt msmtp)
# touch ~/.msmtp.log


# under ubuntu16 try this:
yes | (ai language-pack-zh-hans language-pack-zh-hans-base)

# [[中文

# 使用中文的ubuntu会有什么坏处吗？ - 君子笑的回答 - 知乎https://www.zhihu.com/question/340272351/answer/799642709


ln -sf ~/dotF/zshenv ~/.zshenv
ln -sf ~/dotF/zprofile ~/.zprofile

# 在.zshrc里export LANGUAGE就行，
# 不用：
# echo 'LANG="zh_CN.UTF-8"
# LANGUAGE="zh_CN:zh:en_US:en"'>> ~/.zshrc
# LANGUAGE="zh_CN:zh:en_US:en"'>> ~/.zshenv
# LANGUAGE="zh_CN:zh:en_US:en"'>> ~/.zshenv
# LANGUAGE="zh_CN:zh:en_US:en"'>> /etc/environment

# touch /var/lib/locales/supported.d/local
#
# echo 'en_US.UTF-8 UTF-8
# zh_CN.UTF-8 UTF-8
# zh_CN.GBK GBK
# zh_CN GB2312'>>/var/lib/locales/supported.d/local

locale-gen

ai fonts-droid-fallback
ai ttf-wqy-zenhei
ai ttf-wqy-microhei
ai fonts-arphic-ukai
ai fonts-arphic-uming

locale-gen zh_CN.UTF-8
rm -f /etc/localtime &&  ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  #改 Linux 系统的时区

# 中文]]


rm -rf ~/.SpaceVim.d ~/.Spacevim

cp ./squashfs-root ~/.squashfs-root

curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


mkdir ~/.cache
yes |(mv ~/.tmux ~/.tmux_bk)
yes |(mv ~/.config/ ~/.old_config ;  ln -s ~/dotF/cfg ~)
yes |(cp ~/dotF/local_template_zshrc.zsh ~/.zshrc )

git clone https://github.com/tmux-plugins/tpm ~/dotF/cfg/tmux/plugins/tpm


# 不知道和github下载的nvim是否冲突
ai python-neovim
ai python3-neovim


yes | (ai silversearcher-ag)

#应该需要手动
##需要交互; aptitude install -y postfix
postconf smtputf8_enable=no
postfix start
postfix reload
yes | (cp -rf .muttrc ~ ;cp -rf .msmtprc ~ ; touch ~/.msmtp.log)
# 修改默认python
rm /usr/bin/python
ln -s /usr/bin/python3.? /usr/bin/python
chsh -s `which zsh`



export ZPLUG_HOME=$HOME/dotF/zplug
export ZPLUG_LOADFILE=$HOME/dotF/zplug/zplug_loadfile.sh
git clone https://github.com/zplug/zplug $ZPLUG_HOME


mkdir -p ~/.config/nvim/pack/kite/start/kite
git clone https://github.com/kiteco/vim-plugin.git ~/.config/nvim/pack/kite/start/kite/




git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra


# `没跑过`
echo "这些没跑过"
# sudo apt-get install fortune cowsay
# sudo add-apt-repository --yes ppa:vincent-c/ponysay
# sudo apt-get update
# sudo apt-get install ponysay
# sudo snap install ponysay
echo "这些没跑过-----------------------------end"

# 别改系统默认python啊，不然apt都会出问题
# sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
# sudo update-alternatives --config python3


yes | (ai python3-pip)
\apt autoremove -y -q

yes | (unset ALL_PROXY ; pip install --upgrade pip  ; pip install pysocks)
pip install -r pip_useful_tool.txt

pip uninstall pynvim  # 不删会报错

echo '如果有网络问题，这2行要在 设置PROXY后，手动敲: \n
pip install -r pip_useful_tool.txt  \n
pip uninstall pynvim  \n'

git config --global credential.helper store

export ZPLUG_HOME=$HOME/.zplug                                                                                                                                                                                   export ZPLUG_CACHE_DIR=$ZPLUG_HOME/.cache  # 默认就是这样
export ZPLUG_REPOS=$ZPLUG_HOME/repos  # 默认就是这样
git clone https://github.com/zplug/zplug $ZPLUG_HOME

zsh
