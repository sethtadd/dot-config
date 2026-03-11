#!/bin/sh

case "$1" in
  up)
    brightnessctl set 5%+ >/dev/null
    ;;
  down)
    brightnessctl set 5%- >/dev/null
    ;;
  *)
    exit 1
    ;;
esac

level=$(brightnessctl -m | cut -d, -f4)
notify-send -r 7777 "Brightness" "$level"
