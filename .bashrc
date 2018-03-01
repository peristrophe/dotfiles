PS1="\[\e[0;32m\]\u@\h:\W\\$\[\e[m\] "

alias ..='cd ..'
alias ls='ls -G'
alias ll='ls -Gl'
alias la='ls -GlA'
alias view='vim -R'

# settings for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# settings for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# settings for jvm
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

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
