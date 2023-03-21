epics-versions-for-makefile() {
     epics-versions $@ | tail -n+2 | python -c '
import sys
modules = [line.strip().split(" ", 1) for line in sys.stdin.read().splitlines()]

version_vars = []
path_vars = []

for module, _ in modules:
    module_name, version = module.split("/")

    version_var = "{0}_MODULE_VERSION".format(module_name.upper())
    path = "$(EPICS_MODULES)/{0}/$({1}_MODULE_VERSION)".format(module_name, module_name.upper())
    path_var = module_name.upper()

    version_vars.append("{0}={1}".format(version_var, version))
    path_vars("{0}={1}".format(path_var, path))

print("""
# ===============================================================
# Define the version of modules needed by
# IOC apps or other Support apps
# ===============================================================
""")
print("\n".join(sorted(version_vars)))

print("""
# ============================================================
# External Support module path definitions
# ============================================================
""")
print("\n".join(sorted(path_vars)))
'
}

epics_list_libraries() {
    epics-versions $@ | python -c '
from __future__ import print_function
import os
import sys
import glob

host_arch = os.environ["EPICS_HOST_ARCH"]
lines = sys.stdin.read().splitlines()
modules = {}

for line in lines:
    if line.startswith("Releases under"):
        path = line.split(" ")[-1]
        modules[path] = []
        continue

    modules[path].append(line.strip().split(" ", 1)[0])

version_vars = []
path_vars = []

for sub_path in [os.path.join("lib", host_arch, "*.a"),
                 os.path.join("db", "*.db"),
                 os.path.join("dbd", "*.dbd")]:
    print("***", sub_path, "***")
    for path, module_list in modules.items():
        for module in module_list:
            module_name, version = module.split("/")
            module_path = os.path.join(path, module_name, version)
            print(module_name, "\n\t" + "\n\t".join(glob.glob(os.path.join(module_path, sub_path))))
'
}
