#!/bin/bash

diskutil unmount force /mnt/psbuild || /usr/bin/true
sshfs psbuild-rhel7-01:/reg/neh/home/klauer/ /mnt/psbuild/
