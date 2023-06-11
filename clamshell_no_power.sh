#!/bin/sh
# Disables sleep, so that clamshell mode can work without a power adapted
# attached to the macbook

sudo pmset -a sleep 0
sudo pmset -a hibernatemode 0
sudo pmset -a disablesleep 1
