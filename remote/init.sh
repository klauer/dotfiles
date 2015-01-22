#!/bin/bash
# submodule/remote package initialization

git submodule init
git submodule update

# git-remote-hg dependencies
pip install --user dulwich hg-git mercurial
