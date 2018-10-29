FROM base/archlinux:2018.10.01

WORKDIR /root

ARG aur1="http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch"
ARG aur2="http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch"

RUN echo ${aur}
RUN sed -i '1iServer = '${aur2} /etc/pacman.d/mirrorlist
RUN sed -i '1iServer = '${aur1} /etc/pacman.d/mirrorlist

RUN sed -i -e 's/^#\(en_US\|ja_JP\)\.UTF-8 UTF-8/\1\.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf
RUN export LANG=ja_JP.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN pacman -Syy
RUN pacman -S --noconfirm zsh vim git make
RUN pacman -S --noconfirm bluez bluez-libs

RUN mkdir -p ${HOME}/.vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

RUN git clone https://github.com/peristrophe/dotfiles.git
WORKDIR /root/dotfiles
RUN make deploy
RUN dircolors -p > ${HOME}/.colorrc
RUN dircolors -b ${HOME}/.colorrc >> .zshrc
