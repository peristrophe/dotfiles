#!/bin/sh

[ -z $(which pyenv) ] && echo 'command not found: pyenv' >&2 && exit 1

python_version=$(pyenv install -l | awk '{print $1}' | grep -E '^\d*\.\d*\.\d*$' | tail -1)
pyenv install ${python_version}
pyenv global ${python_version}
pip install -U ../etc/pip-packages.txt
#pip list -o | awk '{print $1}' | xargs pip install -U
pip freeze > ../etc/pip-packages.txt
pyenv global system
