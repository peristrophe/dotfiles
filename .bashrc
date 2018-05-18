PS1="\[\e[0;32m\]\u@\h:\W\\$\[\e[m\] "

# for vim-lightline
export TERM=xterm-256color

# ref: https://yoheikoga.github.io/2016/07/19/change-ls-background-color/
export LSCOLORS='Exfxcxdxbxegedabagacad'

# settings for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# settings for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# settings for jvm
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

[ -f ~/.bash.secure ] && . ~/.bash.secure

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

function git-root() {
    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        cd $(git rev-parse --show-cdup)
    fi
}

function psqljobs() {
psql << __EOQ__
\x
select * from pg_stat_activity;
__EOQ__
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

alias cd='gitcd'
alias ..='cd ..'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -GlA'
alias view='vim -R'
alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:/} brew"

stty stop undef
