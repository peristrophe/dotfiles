#!/bin/bash

here=$(cd $(dirname $0); pwd)
. ${here}/settings.sh

if [ -d "${GITDIR}/fonts" ];
then
    cd "${GITDIR}/fonts"
    git pull
else
    git clone https://github.com/powerline/fonts.git ${GITDIR}/fonts
fi

if [ -d "${GITDIR}/fontpatcher" ];
then
    cd "${GITDIR}/fontpatcher"
    git pull
else
    git clone https://github.com/powerline/fontpatcher.git ${GITDIR}/fontpatcher
fi

cp "${BINDIR}/powerline-fontpatcher-for-NasuM.py" "${GITDIR}/fontpatcher/scripts/"
cd "${GITDIR}/fontpatcher/scripts"
fontforge -lang=py -script "${GITDIR}/fontpatcher/scripts/powerline-fontpatcher-for-NasuM.py" ~/Library/Fonts/NasuM-*.ttf

