#!/bin/bash
TAR_FILENAME=$1
TOP_PATH=$2

find_latest.sh $TOP_PATH > file_list.txt

tar -cvvf ${TAR_FILENAME} --exclude='*/bin' --exclude='*/lib' --exclude='*/.svn' --exclude='*/O.*' --exclude-vcs --files-from=file_list.txt
