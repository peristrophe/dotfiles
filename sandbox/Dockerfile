FROM ubuntu:19.04

WORKDIR /root

ARG username="dev"

ENV TERM="xterm"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y zsh vim git sudo curl wget
#RUN apt-get install -y bluez bluez-tools
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y golang

RUN cat /etc/pam.d/su | grep -n 'wheel members' | head -1 | \
    awk -F: '{print $1}' | xargs -I{} expr {} + 3 | \
    xargs -I{} sed -i '{}iauth sufficient pam_wheel.so trust group=wheel' /etc/pam.d/su
RUN addgroup wheel
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel_group
RUN which zsh | xargs -I{} chsh -s {}
RUN which zsh | xargs -I{} useradd ${username} -m -G wheel -p ${username} -s {}

RUN git clone https://github.com/peristrophe/dotfiles.git
WORKDIR /root/dotfiles
RUN make deploy
RUN mkdir ${PWD}/.vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ${PWD}/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall


USER ${username}
WORKDIR /home/${username}
RUN git clone https://github.com/peristrophe/dotfiles.git
WORKDIR /home/${username}/dotfiles
RUN make deploy
RUN mkdir ${PWD}/.vim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ${PWD}/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall

WORKDIR /home/${username}
RUN curl -L git.io/nodebrew | perl - setup
RUN pip3 install --user pipenv
