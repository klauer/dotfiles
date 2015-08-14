from __future__ import print_function
import sys
import subprocess
import re


def get_location_by_gateway(gateway):
    if gateway.startswith('130.199'):
        return 'campus'
    elif gateway.startswith('10.'):
        return 'beamline'
    else:
        return ''


def get_location_osx():
    try:
        outp = subprocess.check_output('route -n get default'.split(' '))
    except OSError:
        return ''

    m = re.search('gateway: (.*)$', outp, flags=re.MULTILINE)
    if not m:
        return ''

    gateway = m.groups()[0]
    return get_location_by_gateway(gateway)


def get_location_linux():
    return 'beamline'


if sys.platform.startswith('darwin'):
    print(get_location_osx())
elif sys.platform.startswith('linux'):
    print(get_location_linux())
