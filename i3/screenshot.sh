#!/bin/sh
set -eu

screenshots_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshots_dir"
exec maim -s -u "$screenshots_dir/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"
