#!/bin/bash

here=$(cd $(dirname $0); pwd)
. ${here}/settings.sh

git clone https://github.com/powerline/fonts.git ${GITDIR}/fonts
git clone https://github.com/powerline/fontpatcher.git ${GITDIR}/fontpatcher
