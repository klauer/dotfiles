#!/bin/bash
set -e -x

export PLC_TMUX_SESSION=PLC

tmux \
  new-session -d -s ${PLC_TMUX_SESSION}  "ssh psdev-plc; read" \; \
  split-window "ssh ioc-tst-13; read" \; \
  select-layout even-vertical

tmux attach -t ${PLC_TMUX_SESSION}

open '/Applications/Microsoft Remote Desktop.localized/Microsoft Remote Desktop.app'
