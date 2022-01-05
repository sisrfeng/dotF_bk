#wf
set -x
ln -s ~/dotF/.condarc ~/
ln -s ~/dotF/.wf_alias ~/

shopt -s  expand_aliases 
alias ai='apt install -y -qq'
alias apt='apt -y -qq'
alias pip3='pip3 -qq'
alias pip='pip3 -qq'
alias cp='cp -r'


# mkdir ~/.pip ; cat>~/.pip/pip.conf<<EOF
# [global]
# index-url = https::
# EOF

yes | (ai python3-pip zsh)
yes | (ai htop ;ai axel; ai tmux ; ai ack )
yes | (ai ctags; ai build-essential; ai cmake; ai python-dev)
yes | (ai curl; pip3 install --upgrade pip ; pip3 install pudb ; pip3 install gpustat )
yes | (curl -sLf https://spacevim.org/cn/install.sh | bash )
yes | (apt install python3-dev python3-pip python3-setuptools ; pip3 install thefuck; pip install flake8 yapf)
yes | (apt-get install language-pack-zh-hans language-pack-zh-hans-base ; ai peco wget mutt msmtp)
touch ~/.msmtp.log
yes | (pip install pynvim)

mkdir ~/.cache
yes |(cp  ~/dotF/oh-my-tmux ~/dotF/.SpaceVim ~/dotF/.SpaceVim.d ~ ; cp ~/dotF/.cache/Spacevim ~/.cache)
rm -rf ~/.tmux.conf
yes |(ln -s ~/dotF/vimrc  ~/.config/nvim/init.vim)
mkdir ~/.SpaceVim.d
rm -f ~/.SpaceVim.d/init.toml
yes |(ln -s ~/dotF/init.toml ~/.SpaceVim.d/init.toml)
cp ~/ ~/.SpaceVim.d
yes |(cp ~/dotF/.zshrc ~/ )  


chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
#exposing nvim globally
yes | rm /usr/bin/vim
#已经存在目录的话,会啥都不干
mkdir /d
mv squashfs-root /d 
ln -sf /d/squashfs-root/AppRun /usr/bin/vim

yes | ln -s ~/dotF/vimrc ~/.config/nvim/init.vim

yes | (ai silversearcher-ag)
mv /etc/apt/apt.conf /etc/apt/apt.conf.luoyi

#应该需要手动
##需要交互; aptitude install -y postfix
postconf smtputf8_enable=no
postfix start 
postfix reload
yes | (cp -rf .muttrc ~ ;cp -rf .msmtprc ~ ; touch ~/.msmtp.log)
rm -f  /usr/share/vim/vim80/mswin.vim
ln -s ./mswin.vim /usr/share/vim/vim80/mswin.vim
# 修改默认python
rm /usr/bin/python 
ln -s /usr/bin/python3.? /usr/bin/python 
chsh -s `which zsh`; 
ln -s /opt/data/private/trash /t

zsh
