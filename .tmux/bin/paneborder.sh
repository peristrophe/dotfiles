#!/usr/local/bin/zsh

_GIT_STATUS=$(/usr/local/opt/zsh-git-prompt/gitstatus.py)
statuses=("${(@s: :)_GIT_STATUS}")
echo ${statuses[1]}

GITINFO="${GIT_BRANCH_COLOR} ⭠ ${status[1]}"

#if git_status=$(cd $1 && git status 2>/dev/null ); then
#    git_branch="$(echo $git_status| awk 'NR==1 {print $3}')"
#    case $git_status in
#        *Changes\ not\ staged* ) state="#[bg=colour248,fg=black] ± #[fg=default]" ;;
#        *Changes\ to\ be\ committed* ) state="#[bg=blue,fg=black] + #[default]" ;; 
#        * ) state="#[bg=green,fg=black] ✔ #[default]" ;;
#    esac
#    if [[ $git_branch = "master" ]]; then
#        git_info="#[underscore]#[bg=black,fg=blue] ⭠ ${git_branch} #[default]${state}"
#    else
#        git_info="#[underscore]#[bg=black,fg=colour014] ⭠ ${git_branch} #[default]${state}"
#    fi
#else
#    git_info=""
#fi
#
#directory="#[underscore]#[bg=black,fg=cyan]$1#[default]"
#
#echo "$git_info"
