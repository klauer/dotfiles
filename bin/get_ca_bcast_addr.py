# borrowed from dchabot

import subprocess
import re


def replace_bcast(inp):
    l = inp.rsplit('.',1)
    l[-1] = '.255'
    return ''.join(l)


if __name__ == '__main__':
    outp = subprocess.check_output(['ifconfig'])
    #print outp
    lines = re.findall('10\..*', outp)
    matches = [ line.split() for line in lines]
    nics = [match[0] for match in matches if match[0].startswith('10')]

    # if only one '10.x.y.z' subnet NIC was found, use that. Otherwise, look closer.
    if not nics:
        print ''
    elif len(nics) == 1:
        print replace_bcast(nics[0])
    else:
        nic = [nic for nic in nics if nic.find('.0.') > 0]
        print replace_bcast(nic[0])

