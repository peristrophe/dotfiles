#!/bin/sh


set -eux


function sweep() {
    [ -f ~/Downloads/_install_font.zip ] && rm -f ~/Downloads/_install_font.zip
    [ -d ~/Downloads/_install_font ] && rm -rf ~/Downloads/_install_font
}


trap sweep 0 1 2 3 15


case $1 in
    martian-mono | MartianMono)
        url='https://github.com/evilmartians/mono/releases/download/v1.0.0/martian-mono-1.0.0-ttf.zip'
        prefix='MartianMono'
        extension='ttf'
        ;;
    hack-gen | HackGen)
        url='https://github.com/yuru7/HackGen/releases/download/v2.8.0/HackGen_NF_v2.8.0.zip'
        prefix='HackGen'
        extension='ttf'
        ;;
    *)
        echo 'invalid argument'
        exit 1
esac


find ~/Library/Fonts -type f -name "${prefix}*.${extension}" | wc -l | xargs test 0 -eq


curl -sSL $url -o ~/Downloads/_install_font.zip


unzip -jq ~/Downloads/_install_font.zip -d ~/Downloads/_install_font


mv ~/Downloads/_install_font/${prefix}*.${extension} ~/Library/Fonts

