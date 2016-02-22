#!/bin/bash

VIM_DIR=$(readlink -f `dirname $0`)

echo " [-] Installing vim files from ${VIM_DIR}..."

pushd "${VIM_DIR}"

[ -f ${VIM_DIR}/bundle/vundle/.git ] || git submodule init -- bundle/vundle
git submodule update
cd bundle/vundle
git checkout master
git pull

[ -f /usr/share/vim/vimfiles/bash-support/templates/Templates ] || ( mkdir -p /usr/share/vim/vimfiles/bash-support/templates ; touch /usr/share/vim/vimfiles/bash-support/templates/Templates ; )

if [ -f /root/.vimrc ] ; then
    echo " [#] Warning: /root/.vimrc already exists. Re-link to ${VIM_DIR}/vimrc manually." >&2
else
    if [ -L /root/.vimrc ] ; then
        echo " [-] Replacing old symlink in /root/.vimrc to repoint to ${VIM_DIR}/vimrc"
        rm -f /root/.vimrc
    fi
    ln -s ${VIM_DIR}/vimrc /root/.vimrc
    
    if [ -L /root/.gvimrc ] ; then
        rm -f /root/.gvimrc
    elif [ ! -f /root/.gvimrc ] ; then
        ln -s ${VIM_DIR}/gvimrc /root/.gvimrc
    fi
fi

popd

echo " [+] Done. Run vim and then execute ':BundleUpdate' and you are all set."
