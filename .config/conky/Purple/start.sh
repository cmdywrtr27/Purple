#!/bin/bash

killall conky
sleep 2s

conky -c $HOME/.config/conky/Purple/Purple.conf &> /dev/null &

exit
