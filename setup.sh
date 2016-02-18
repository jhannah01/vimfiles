#!/bin/bash

VIM_DIR=$(realpath `dirname $0`)

echo " [-] Installing vim files from ${VIM_DIR}..."

[ -f ${VIM_DIR}/bundle/vundle/.git ] || git -C "${VIM_DIR}" submodule init -- "${VIM_DIR}/bundle/vundle"
git -C "${VIM_DIR}" submodule update
git -C "${VIM_DIR}/bundle/vundle" checkout master
git -C "${VIM_DIR}/bundle/vundle" pull

if [ -f /root/.vimrc ] ; then
    echo " [#] Warning: /root/.vimrc already exists. Re-link to ${VIM_DIR}/vimrc manually." >&2
else
    if [ -L /root/.vimrc ] ; then
        echo " [-] Replacing old symlink in /root/.vimrc to repoint to ${VIM_DIR}/vimrc"
        rm -f /root/.vimrc
        [ -f /root/.gvimrc ] && rm -f /root/.gvimrc
    fi
    ln -s ${VIM_DIR}/vimrc /root/.vimrc
    ln -s ${VIM_DIR}/gvimrc /root/.gvimrc
fi

echo " [+] Done. Run vim and then execute ':BundleUpdate' and you are all set."
