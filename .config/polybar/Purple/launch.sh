#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/Purple/config.ini top &
polybar -c ~/.config/polybar/Purple/config.ini top2 &
