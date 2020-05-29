#!/bin/bash

Color_off='\033[0m'       # Text Reset
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green

msg() {
    echo -e "${1}"
}

app_install() {
    if [[ $EUID -ne 0 ]]; then
        if ! sudo apt install -y "${1}"; then
            msg "${Red} ${1} install failed${Color_off}"
            exit 1
        fi
    else
        if ! apt install -y "${1}"; then
            msg "${Red} ${1} install failed${Color_off}"
            exit 1
        fi
    fi
}

checkapp() {
    if ! [ -x "$(command -v "${1}")" ]; then
        if ! dpkg -s "${1}" &> /dev/null; then
            msg "${Red} Package ${1} is NOT installed!${Color_off}"
            app_install "${1}"
        fi
    fi
}

CHANGE_APT_TH=false
git config --global url."https://".insteadOf git://
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
msg "${Green}Installed Vundle${Color_off}"
# git clone --recursive -j8 https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim 
git clone --recursive -j8 https://github.com/ycm-core/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cp vimrc ~/.vimrc

if [ "${CHANGE_APT_TH}" = true ]; then
msg "${Green}Change apt source list: tsinghua.edu.cn ${Color_off}"
cat <<EOF > /etc/apt/sources.list
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
EOF
fi
apt update

pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

export DEBIAN_FRONTEND=noninteractive

pip install yapf
checkapp ctags
checkapp clang
checkapp build-essential 
checkapp cmake 
checkapp python3-dev
checkapp silversearcher-ag
checkapp pylint
checkapp shellcheck

vim -c PluginInstall -c qall

python3 ~/.vim/bundle/YouCompleteMe/install.py --all

msg "${Green}Installed Done!${Color_off}"
