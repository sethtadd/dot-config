#!/usr/bin/env bash
set -euo pipefail

internal_output="eDP-1"
connected_outputs=$(xrandr --query | awk '/ connected/ {print $1}')
external_output=""

for output in $connected_outputs; do
  if [ "$output" != "$internal_output" ]; then
    external_output="$output"
    break
  fi
done

all_outputs=$(xrandr --query | awk '/(connected|disconnected)/ {print $1}')

if [ -n "$external_output" ]; then
  xrandr --output "$internal_output" --auto --output "$external_output" --auto --above "$internal_output"

  for output in $all_outputs; do
    if [ "$output" != "$internal_output" ] && [ "$output" != "$external_output" ]; then
      xrandr --output "$output" --off
    fi
  done
else
  xrandr --output "$internal_output" --auto

  for output in $all_outputs; do
    if [ "$output" != "$internal_output" ]; then
      xrandr --output "$output" --off
    fi
  done
fi
