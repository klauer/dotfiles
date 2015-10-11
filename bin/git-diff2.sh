#!/bin/bash

if [ $# -ne 3 ]; then 
    echo "Usage: filename REV1 REV2";
    exit 1;
fi

TF1="$(mktemp -t $2)_$(basename $1)"
echo "file1: $TF1"
echo "$2:$1" > $TF1 
git show $2:$1 >> $TF1

TF2="$(mktemp -t $3)_$(basename $1)"
echo "file2: $TF1"
echo "$3:$1" > $TF2 
git show $3:$1 >> $TF2

vimdiff $TF1 $TF2
