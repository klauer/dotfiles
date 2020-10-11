#!/bin/bash

diskutil unmount force /mnt/vm || /usr/bin/true
sshfs windows-vm:/ /mnt/vm/
