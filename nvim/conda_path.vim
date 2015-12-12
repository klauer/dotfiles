" vim-conda-path

python << EOF
# modified from
# https://github.com/cjrh/vim-conda/blob/master/plugin/vim-conda.vim

import vim
import os
import subprocess
import json
import glob


def find_conda_lib_paths():
    conda_default_env = os.getenv('CONDA_DEFAULT_ENV')
    if not conda_default_env:
        pass
    else:
        output = subprocess.check_output('conda info --json', shell=True,
                                         executable=os.getenv('SHELL'),
                                         stdin=subprocess.PIPE,
                                         stderr=subprocess.PIPE)
        d = json.loads(output)
        if 'default_prefix' in d:
            base_path = d['default_prefix']
            lib_path = os.path.join(base_path, 'lib')
            python_dirs = glob.glob(os.path.join(lib_path, 'python*'))
            for pydir in python_dirs:
                yield os.path.join(lib_path, pydir, '**')
                # yield os.path.join(lib_path, pydir, 'site-packages', '**')


def add_conda_lib_paths():
    for lib_path in find_conda_lib_paths():
        vim.command("set path+={}".format(lib_path))

add_conda_lib_paths()
EOF
