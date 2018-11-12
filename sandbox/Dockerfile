FROM base/archlinux:2018.11.01

WORKDIR /root

ARG aur1="http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch"
ARG aur2="http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch"
ARG username="dev"

ENV TERM="xterm"

RUN sed -i -e 's/^#\(en_US\|ja_JP\)\.UTF-8 UTF-8/\1\.UTF-8 UTF-8/g' /etc/locale.gen
RUN locale-gen
RUN echo 'LANG=ja_JP.UTF-8' > /etc/locale.conf
RUN export LANG=ja_JP.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN sed -i '1iServer = '${aur2} /etc/pacman.d/mirrorlist
RUN sed -i '1iServer = '${aur1} /etc/pacman.d/mirrorlist
RUN pacman -Syy
RUN pacman -S --noconfirm gcc zsh vim git make sudo
RUN pacman -S --noconfirm bluez bluez-libs
RUN pacman -S --noconfirm python3 python-pip
RUN pacman -S --noconfirm go

RUN pacman -S --noconfirm rust rust-docs rustup cargo
RUN rustup install stable
RUN rustup default stable

RUN pacman -S --noconfirm elixir
RUN ln -sf "$(find /usr -type f -name 'elixir' | head -n 1)" /usr/bin/elixir

RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel_group
RUN which zsh | xargs -I{} chsh -s {}

RUN git clone https://github.com/peristrophe/dotfiles.git
WORKDIR /root/dotfiles
RUN make deploy

RUN mkdir ${PWD}/.vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ${PWD}/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

RUN which zsh | xargs -I{} useradd ${username} -m -G wheel -p ${username} -s {}



USER ${username}
WORKDIR /home/${username}

#### show installed location: "python -m site --user-site"
RUN pip install --user PyYAML rsa urllib3
#RUN pip install --user numpy scipy pandas gensim scikit-learn

RUN rustup default stable

RUN git clone https://github.com/peristrophe/dotfiles.git
WORKDIR /home/${username}/dotfiles
RUN make deploy

RUN mkdir ${PWD}/.vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ${PWD}/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall
WORKDIR /home/${username}

#ENTRYPOINT ["zsh", "-c"]
