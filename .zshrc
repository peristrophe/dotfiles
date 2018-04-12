## Created by newuser for 5.4.2
#if [ -f /usr/local/opt/zsh-git-prompt/zshrc.sh ];
#then
#    . /usr/local/opt/zsh-git-prompt/zshrc.sh
#    ZSH_THEME_GIT_PROMPT_PREFIX="["
#    ZSH_THEME_GIT_PROMPT_SUFFIX=" ]"
#    ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[white]%}"
#    ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{ %G%}"
#    ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{x%G%}"
#    ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{+%G%}"
#    ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
#    ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
#    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"
#    RPROMPT='$(git_super_status)'
#fi
autoload -Uz add-zsh-hook
add-zsh-hook precmd tmux-refresh

#PROMPT='%F{green}%n@%m:%c%# %f'
#PROMPT="%B%K{231}%F{23} $(tmux display -p '#P') %b%K{220}%F{231}%F{black} %c %F{220}%k%f "
PROMPT="%B%K{220}%F{52} $(tmux display -p '#P') %b%K{172}%F{220}%F{black} %c %F{172}%k%f "

# for vim-lightline
export TERM=xterm-256color

# ref: https://yoheikoga.github.io/2016/07/19/change-ls-background-color/
export LSCOLORS='Exfxcxdxbxegedabagacad'

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# settings for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# settings for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# settings for jvm
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

[ -f ~/.zsh.secure ] && . ~/.zsh.secure

alias cd='gitcd'
alias ..='cd ..'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -GlA'
alias view='vim -R'
alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:/} brew"
alias history='history -E 1'

function tdq() {
    [ $# -lt 1 ] && echo 'too few arguments.' >&2 && return 1

    local query=${1}
    shift
    td query -wc -T 'presto' -f 'tsv' -d 'studysapuri_masters' -q "${PWD}/${query}" ${@}
}

function urlEnc() {
    if [ -p /dev/stdin ]
    then
        cat - | nkf -WwMQ | tr '=' '%'
    else
        echo $1 | nkf -WwMQ | tr '=' '%'
    fi
}

function urlDec() {
    if [ -p /dev/stdin ]
    then
        cat - | nkf --url-input -W
    else
        echo $1 | nkf --url-input -W
    fi
}

function gitcd() {
    if [[ ! ${1} =~ ^/.* || ${1} =~ ^${HOME}.* ]]; then
        builtin cd "${@}"
        return
    fi

    local insideProject=`git rev-parse --is-inside-work-tree 2>/dev/null`
    if [ ! "${insideProject}" = "true" ]; then
        builtin cd "${@}"
        return
    fi

    local currentDir=`pwd 2>/dev/null`
    local projectRoot=`git rev-parse --show-toplevel 2>/dev/null`

    if [ "${currentDir}" = "${projectRoot}" -a "${1}" = "/" ]; then
        builtin cd "/"
        return
    fi

    if [ -d "${projectRoot}${1}" ]; then
        builtin cd "${projectRoot}${1}"
    else
        builtin cd "${@}"
    fi
    return
}

function tmux-refresh() {
    [ ! -z $TMUX ] && tmux refresh-client -S
}
