#!/bin/bash

clock=(
  icon=
  update_freq=10
  script="$PLUGIN_DIR/clock.sh"
)

sketchybar --add item clock right    \
           --set clock "${clock[@]}" \
           --subscribe clock system_woke
