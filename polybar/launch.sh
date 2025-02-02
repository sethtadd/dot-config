#!/usr/bin/env bash

polybar-msg cmd quit

# Log file
echo '---> Launching Polybar' | tee -a /tmp/polybar.log

polybar -r example >>/tmp/polybar.log 2>&1 &

echo '---> Polybar launched' | tee -a /tmp/polybar.log
