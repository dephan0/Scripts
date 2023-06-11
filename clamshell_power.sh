#!/bin/sh
# Enables sleep, so that clamshell mode requires a power adpater to be attached
# in order to work.

sudo pmset -a sleep 1
sudo pmset -a hibernatemode 3
sudo pmset -a disablesleep 0
