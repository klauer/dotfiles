#!/usr/bin/env python

import ast
import os
import sys
import re

key_re = re.compile(r'([a-z_]+)\s*:', re.IGNORECASE)

try:
    json_output = sys.argv[1] == '--json'
except IndexError:
    json_output = False

def load_config_file(fn):
    entries = []
    loading = False
    entry = None
    with open(fn, 'rt') as f:
        lines = f.read().splitlines()
        for line in lines:
            if 'procmgr_config' in line:
                loading = True
                continue
            if not loading:
                continue
            if 'id:' in line:
                if '}' in line:
                    entries.append(line)
                else:
                    entry = line
            elif entry is not None:
                entry += line
                if '}' in entry:
                    entries.append(entry)
                    entry = None

    result = []
    for entry in entries:
        result.append(ast.literal_eval(key_re.sub(r'"\1":', entry.strip(', \t'))))
    return result


config_files = sys.stdin.read().splitlines()

iocs = [
    ioc_info
    for fn in config_files
    for ioc_info in load_config_file(fn)
]

iocs.sort(key=lambda ioc: ioc.get("host", '?'))

def find_stcmd(directory, ioc_id):
    if directory.startswith("ioc"):
        directory = os.path.join("/reg/g/pcds/epics", directory)

    build_path = os.path.join(directory, "build", "iocBoot", ioc_id)
    # print(build_path, "?")
    if os.path.exists(build_path):
        return os.path.join(build_path, "st.cmd")
    return os.path.join(directory, "iocBoot", ioc_id, "st.cmd")


for ioc_info in sorted(iocs, key=lambda ioc_info: ioc_info.get("host", '?')):
    # table.add_row([str(ioc_info.get(key, '?')) for key in table.field_names])
    directory = ioc_info.get("dir", None)
    disable = ioc_info.get("disable", False)
    if not directory:
        continue
    ioc_id = ioc_info.get("id", None)
    stcmd = find_stcmd(directory, ioc_id)
    if os.path.exists(stcmd):
        print(stcmd)
    elif not disable:
        # print("missing stcmd", stcmd, ioc_info)
        ...
