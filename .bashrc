# ref: https://yoheikoga.github.io/2016/07/19/change-ls-background-color/
export LSCOLORS='Exfxcxdxbxegedabagacad'


stty stop undef


#     m   reset
# 0;30m   Black
# 0;31m   Red
# 0;32m   Green
# 0;33m   Yellow
# 0;34m   Blue
# 0;35m   Purple
# 0;36m   Cyan
# 0;37m   White
if [ "$(whoami)" = "root" ]; then
    PS1="\[\e[1;31m\]\u@\[\e[m\]\[\e[1;33m\]\h:\[\e[m\]\[\e[1;32m\]\w% \[\e[m\]"
else
    PS1="\[\e[1;33m\]\u@\[\e[m\]\[\e[1;32m\]\h:\[\e[m\]\[\e[1;36m\]\w$ \[\e[m\]"
fi


# for vim-lightline
export TERM=xterm-256color


# settings for pyenv
if [ -d ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


# settings for rbenv
if [ -d ~/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi


# settings for goenv
if [ -d ~/.goenv ]; then
    export PATH="$HOME/.goenv/bin:$PATH"
    eval "$(goenv init -)"
fi


# settings for jvm
if [ -f /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi


# settings for nodebrew
if [ -d ~/.nodebrew ]; then
    export PATH="$HOME/.nodebrew/current/bin:$PATH"
fi


# settings for rust
if [ -d ~/.cargo ]; then
    source $HOME/.cargo/env
fi


# settings for android studio
if [ -d ~/Library/Android/sdk ]; then
    export ANDROID_HOME="$HOME/Library/Android/sdk"
    export PATH="$PATH:$ANDROID_HOME/tools"
    export PATH="$PATH:$ANDROID_HOME/tools/bin"
    export PATH="$PATH:$ANDROID_HOME/platform-tools"
fi


export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


case $(uname) in
    "Darwin")
        # ref: https://yoheikoga.github.io/2016/07/19/change-ls-background-color/
        export LSCOLORS='Exfxcxdxbxegedabagacad'
        export LANG=ja_JP.UTF-8
        export PATH="$HOME/Library/Python/3.7/bin:$PATH"

        alias cd='gitcd'
        alias ..='cd ..'
        alias ls='ls -G'
        alias ll='ls -Gl'
        alias la='ls -GlA'
        alias view='vim -R'
        alias brew="env PATH=${PATH/\/Users\/${USER}\/\.pyenv\/shims:/} brew"
        alias history='history -E 1'
        alias relogin='exec $SHELL -l'
        alias pythonlibs='python -c "import sys, pprint; pprint.pprint(sys.path[1:], indent=2)"'
        ;;
    "Linux")
        if [ -f "$(which dircolors)" -a -f ~/.colorrc ]; then
            dircolors -b ~/.colorrc > /tmp/ls_colors
            source /tmp/ls_colors
        fi
        #export LANG=ja_JP.UTF-8

        alias cd='gitcd'
        alias ..='cd ..'
        alias ls='ls --color=auto'
        alias ll='ls -l --color=auto'
        alias la='ls -lA --color=auto'
        alias view='vim -R'
        alias history='history -E 1'
        alias relogin='exec $SHELL -l'
        alias pythonlibs='python -c "import sys, pprint; pprint.pprint(sys.path[1:], indent=2)"'
        ;;
    *)
        ;;
esac


function tdq() {
    [ $# -lt 1 ] && echo 'too few arguments.' >&2 && return 1
    [ -f "${1}" ] && local queryfromfile=true || queryfromfile=false

    local query=${1}
    shift
    if ${queryfromfile};
    then
        echo "td query -wc -T presto -f tsv -d studysapuri -q ${PWD}/${query} ${@}"
        td query -wc -T 'presto' -f 'tsv' -d 'studysapuri' -q "${PWD}/${query}" ${@}
    else
        echo "td query -wc -T presto -f tsv -d studysapuri \"${query}\" ${@}"
        td query -wc -T 'presto' -f 'tsv' -d 'studysapuri' "${query}" ${@}
    fi
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


function tmux-prepare() {
    tmux split-pane
    tmux split-pane -h
    #tmux select-layout main-horizontal
}
