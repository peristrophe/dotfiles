#!/bin/bash

here=$(cd $(dirname $0); pwd)
. ${here}/settings.sh

fontforge -lang=py -script ${BINDIR}/powerline-fontpatcher-for-NasuM.py ~/Library/Fonts/NasuM-*.ttf
