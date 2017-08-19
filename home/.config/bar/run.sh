#!/bin/bash

# Clean up
killall -q lemonbar
killall -q stalonetray

# The left-hand monitor will be located at coords 0,0
monline=`xrandr -q | grep '+0+0'`
monx=`echo $monline | sed "s@.* \([0-9]\+\)x[0-9]\+.*@\1@"`

barwidth=$((monx - 320))

$HOME/.config/bar/contents.sh | lemonbar -p -g ${barwidth}x16+0+0 \
    -F '#d3d0c8' -B '#2d2d2d' \
    -o -1 -f "Fantasque Sans Mono-11" \
    -o -2 -f "Font Awesome-10" | bash &

sleep 1

trayx=$((monx - 320))
stalonetray --geometry 20x1+${trayx}+0 --sticky true --kludges "force_icons_size,fix_window_pos" &

# Sleep right here before handing back so that we're sure that the tray is up
sleep 1
