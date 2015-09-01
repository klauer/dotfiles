from __future__ import print_function
import sys
import subprocess
import re


def get_location_by_gateway(interface, gateway):
    if gateway.startswith('130.199'):
        return 'campus'
    elif interface in ('en0', ):
        if gateway.startswith('10.2.'):
            return 'campus'
        else:
            return ''
    elif gateway.startswith('10.'):
        return 'beamline'
    else:
        return ''


def get_location_osx():
    try:
        outp = subprocess.check_output('route -n get default'.split(' '))
    except OSError:
        return ''

    if isinstance(outp, bytes):
        outp = outp.decode('latin-1')

    m = re.search('interface: (.*)$', outp, flags=re.MULTILINE)
    if not m:
        return ''

    interface = m.groups()[0]

    m = re.search('gateway: (.*)$', outp, flags=re.MULTILINE)
    if not m:
        return ''

    gateway = m.groups()[0]
    return get_location_by_gateway(interface, gateway)


def get_location_linux():
    return 'beamline'


if sys.platform.startswith('darwin'):
    print(get_location_osx())
elif sys.platform.startswith('linux'):
    print(get_location_linux())
