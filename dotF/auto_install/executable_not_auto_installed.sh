set -x
setopt aliases
apt install -y -qq
alias ai='apt install -y -qq'
alias apt='apt -y -qq'
alias pip3='pip3 -qq'
alias cp='cp -r'

# 不确定对不对
git clone --depth 1 https://github.com/junegunn/fzf.git ~/d/fzf
~/d/fzf/install


ln -sf ~/dotF/rc.zsh
ln -sf ~/dotF/.pip/ ~/
ln -sf ~/dotF/cfg/.condarc ~/
ln -sf ~/dotF/ssh/config ~/.ssh/config
ln -sf ~/dotF/cfg/git/ ~/.ssh/config
ln -sf ~/dotF/cfg/git/gitconfig ~/.gitconfig
