#!/bin/bash

IOC_TOP_PATH=$1

find $IOC_TOP_PATH -maxdepth 2 -name 'R*' | sort --version-sort |
python -c "
import sys

iocs = {}
for ioc in sys.stdin.read().splitlines():
    if '/' not in ioc:
        continue
    ioc, version = ioc.rsplit('/', 1)

    if ioc not in iocs:
        iocs[ioc] = []
    iocs[ioc].append(version)

for ioc, versions in iocs.items():
    version = versions[-1]
    print(f'{ioc}/{version}')
"
