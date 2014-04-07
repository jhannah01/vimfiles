#!/bin/bash

root=$(dirname $0)
pushd $root

git submodule init -- bundle/vundle
git submodule update

pushd bundle/vundle
git checkout master
git pull origin master -u
popd

vim -c ':BundleUpdate'

pushd bundle/YouCompleteMe
./install.sh
popd

[ -L ~/.vimrc ] || ln -s $root/vimrc ~/.vimrc

sudo bash -c "[ -L /root/.vimrc ] || ln -s $root/vimrc /root/.vimrc"

popd


