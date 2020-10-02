#!/bin/bash

source /reg/g/pcds/pyps/conda/dev_conda

/usr/bin/ls -d /reg/g/pcds/epics/ioc/* > all_ioc_dirs

date=$(date '+%Y%m%d')

for ioc_dir in $(cat all_ioc_dirs); do
    echo ${ioc_dir}
    tar_file=$(basename $ioc_dir)_${date}.tgz
    . run_backup.sh ${tar_file} ${ioc_dir}
done
