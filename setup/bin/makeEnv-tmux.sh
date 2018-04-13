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

[ -f ~/Downloads/NasuFonts.zip ] && rm -f ~/Downloads/NasuFonts.zip
[ -d ~/Downloads/NasuFonts ] && rm -rf ~/Downloads/NasuFonts

if [ $(which wget) ];
then
    wget 'https://ja.osdn.net/frs/chamber_redir.php?m=jaist&f=%2Fusers%2F7%2F7587%2FNasuFont-20141215.zip' -O ~/Downloads/NasuFonts.zip
elif [ $(which curl) ];
then
    curl -L 'https://ja.osdn.net/frs/chamber_redir.php?m=jaist&f=%2Fusers%2F7%2F7587%2FNasuFont-20141215.zip' -o ~/Downloads/NasuFonts.zip
else
    exit 1
fi

mkdir -p ~/Downloads/NasuFonts
unzip -j ~/Downloads/NasuFonts.zip "*.ttf" -d ~/Downloads/NasuFonts

cp "${BINDIR}/powerline-fontpatcher-for-NasuM.py" "${GITDIR}/fontpatcher/scripts/"
cd "${GITDIR}/fontpatcher/scripts"
fontforge -lang=py -script "${GITDIR}/fontpatcher/scripts/powerline-fontpatcher-for-NasuM.py" ~/Downloads/NasuFonts/NasuM-*.ttf

cp ${GITDIR}/fontpatcher/scripts/NasuM-*.ttf ~/Library/Fonts/
