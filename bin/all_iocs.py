"""
Used to import IOC configuration information from SLAC PCDS IocManager-format
configuration files.
"""

import argparse
import ast
import logging
import os
import pathlib
import re
from typing import Any, Callable, List, Optional, Union, Dict

import prettytable

IocInfoDict = Dict[str, Union[str, Dict[str, str], List[str]]]

logger = logging.getLogger(__name__)
DESCRIPTION = __doc__

KEY_RE = re.compile(r"([a-z_]+)\s*:", re.IGNORECASE)
EPICS_SITE_TOP = os.environ.get("EPICS_SITE_TOP", "/reg/g/pcds/epics")
REQUIRED_KEYS = {"id", "host", "port", "dir"}


def validate_config_keys(cfg: IocInfoDict) -> bool:
    """Validate that a configuration has all required keys."""
    return all(key in cfg and cfg[key] for key in REQUIRED_KEYS)


def parse_config(lines: List[str]) -> List[IocInfoDict]:
    """
    Parse an IOC manager config to get its IOCs.

    Parameters
    ----------
    lines : list of str
        List of raw configuration file lines.

    Returns
    -------
    ioc_info : list of IOC info dictionaries
        List of IOC info
    """
    entries = []
    loading = False
    entry = None

    for line in lines:
        if "procmgr_config" in line:
            loading = True
            continue
        if not loading:
            continue
        if "id:" in line:
            if "}" in line:
                entries.append(line)
            else:
                entry = line
        elif entry is not None:
            entry += line
            if "}" in entry:
                entries.append(entry)
                entry = None

    def fix_entry(entry):
        return ast.literal_eval(KEY_RE.sub(r'"\1":', entry.strip(", \t")))

    result = []
    for entry in entries:
        try:
            result.append(fix_entry(entry))
        except Exception:
            logger.exception("Failed to fix up IOC manager entry: %s", entry)

    return result


def load_config_file(fn: Union[str, pathlib.Path]) -> List[IocInfoDict]:
    """
    Load a configuration file and return the IOCs it contains.

    Parameters
    ----------
    fn : str or pathlib.Path
        The configuration filename

    Returns
    -------
    ioc_info : list of IOC info dictionaries
        List of IOC info
    """
    with open(fn, "rt") as f:
        lines = f.read().splitlines()

    iocs = parse_config(lines)

    for ioc in list(iocs):
        if not validate_config_keys(ioc):
            iocs.remove(ioc)
        else:
            # Add "config_file" and rename some keys:
            ioc["config_file"] = str(fn)
            ioc["name"] = ioc.pop("id")
            alias = ioc.get("alias", None)
            if alias and alias != ioc["name"]:
                ioc["name_alias"] = "{name} ({alias})".format(**ioc)
            else:
                ioc["name_alias"] = "{name}".format(**ioc)
            ioc["host_port"] = f'{ioc["host"]}:{ioc["port"]}'
            ioc["script"] = find_stcmd(ioc["dir"], ioc["name"])
            ioc["binary"] = find_binary_from_hashbang(ioc["script"])

    return iocs


def find_binary_from_hashbang(
    startup_script: Optional[Union[str, pathlib.Path]],
    must_exist: bool = False,
) -> Optional[str]:
    """
    Find the binary associated with a given startup script by looking at its
    shebang.

    Returns
    -------
    binary_path : str or None
        The path to the binary, if available.
    """
    if startup_script is None:
        return None

    try:
        with open(startup_script, "rt") as fp:
            first_line = fp.read().splitlines()[0]
    except Exception:
        return None

    if first_line.startswith("#!"):
        parent_dir = pathlib.Path(startup_script).parent
        binary = parent_dir / first_line.lstrip("#!")
        if not must_exist or binary.exists():
            return str(binary.resolve())


def find_stcmd(directory: str, ioc_id: str) -> str:
    """Find the startup script st.cmd for a given IOC."""
    if directory.startswith("ioc"):
        directory = os.path.join(EPICS_SITE_TOP, directory)

    suffix = os.path.join("iocBoot", ioc_id, "st.cmd")
    # Templated IOCs are... different:
    options = [
        os.path.join(directory, "children", "build", suffix),
        os.path.join(directory, "build", suffix),
        os.path.join(directory, suffix),
        os.path.join(directory, "st.cmd"),
    ]

    for option in options:
        if os.path.exists(option):
            return option

    return ""


def get_iocs_from_configs(
    configs: List[Union[str, pathlib.Path]],
    sorter: Optional[Callable[[IocInfoDict], Any]] = None
) -> List[IocInfoDict]:
    """
    Get IOC information in a list of dictionaries.

    Parameters
    ----------
    configs : list[str or pathlib.Path]
        Configuration filenames to load.
    sorter : callable, optional
        Sort IOCs with this, defaults to sorting by host name and then IOC name.

    Returns
    -------
    ioc_info : list of IOC info dictionaries
        List of IOC info
    """
    configs = [
        pathlib.Path(config).resolve()
        for config in configs or []
    ]

    def default_sorter(ioc):
        return (ioc["host"], ioc["name"])

    iocs = (
        ioc
        for fn in set(configs)
        for ioc in load_config_file(fn)
    )

    return list(sorted(iocs, key=sorter or default_sorter))


def build_arg_parser(parser=None):
    if parser is None:
        parser = argparse.ArgumentParser()

    parser.description = DESCRIPTION
    parser.formatter_class = argparse.RawTextHelpFormatter

    parser.add_argument(
        "configs", type=str, nargs="+", help="Configuration file location(s)"
    )

    parser.add_argument(
        "--json", dest="as_json", action="store_true", help="Output raw JSON"
    )

    parser.add_argument(
        "--columns", nargs="*", type=str, help="Columns to display"
    )
    return parser


def main(configs, as_json=False, columns=None) -> List[IocInfoDict]:
    iocs = get_iocs_from_configs(configs)
    if as_json:
        print(json.dumps(iocs, indent=4))
    else:
        table = prettytable.PrettyTable()
        table.field_names = columns or ["host_port", "name_alias", "script"]
        for ioc in sorted(iocs, key=lambda ioc: ioc.get("host", '?')):
            table.add_row([str(ioc.get(key, '?')) for key in table.field_names])

        print(table)
    return iocs


if __name__ == "__main__":
    parser = build_arg_parser()
    args = parser.parse_args()
    iocs = main(**vars(args))
