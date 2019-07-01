#!/bin/bash

diskutil unmount force /mnt/windows || /usr/bin/true
sshfs windows:/mnt/c/ /mnt/windows/
