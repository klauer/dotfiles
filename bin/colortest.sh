#!/bin/bash
# This file was originally taken from iterm2 https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh
#
#   This file echoes a bunch of 24-bit color codes
#   to the terminal to demonstrate its functionality.
#   The foreground escape sequence is ^[38;2;<r>;<g>;<b>m
#   The background escape sequence is ^[48;2;<r>;<g>;<b>m
#   <r> <g> <b> range from 0 to 255 inclusive.
#   The escape sequence ^[0m returns output to default

setBackgroundColor()
{
    #printf '\x1bPtmux;\x1b\x1b[48;2;%s;%s;%sm' $1 $2 $3
    printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}

resetOutput()
{
    echo -en "\x1b[0m\n"
}

# Gives a color $1/255 % along HSV
# Who knows what happens when $1 is outside 0-255
# Echoes "$red $green $blue" where
# $red $green and $blue are integers
# ranging between 0 and 255 inclusive
rainbowColor()
{ 
    let h=$1/43
    let f=$1-43*$h
    let t=$f*255/43
    let q=255-t
    
    case $h in 
        0) echo "255 $t 0";;
        1) echo "$q 255 0";;
        2) echo "0 255 $t";;
        3) echo "0 $q 255";;
        4) echo "$t 0 255";;
        5) echo "255 0 $q";;
    esac

}

for i in `seq 0 127`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput
