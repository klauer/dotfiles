# borrowed from dchabot

from __future__ import print_function
import subprocess
import re


def replace_bcast(inp):
    l = inp.rsplit('.',1)
    l[-1] = '.255'
    return ''.join(l)


def get_bcast():
    try:
        outp = subprocess.check_output(['/sbin/ifconfig'])
    except OSError:
        outp = subprocess.check_output(['ifconfig'])

    # print outp
    outp = outp.decode('latin-1')
    lines = re.findall('10\..*', outp)
    matches = [line.split() for line in lines]
    nics = [match[0] for match in matches if match[0].startswith('10')]

    # if only one '10.x.y.z' subnet NIC was found, use that. Otherwise, look closer.
    if not nics:
        return ''
    elif len(nics) == 1:
        return replace_bcast(nics[0])
    else:
        nic = [nic for nic in nics
               if '.0.' in nic]
        return replace_bcast(nic[0])


if __name__ == '__main__':
    print(get_bcast())
