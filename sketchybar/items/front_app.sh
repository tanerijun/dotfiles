#!/bin/sh

front_app=(
  label.font.size=14.0
  icon.drawing=off
  display=active
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left         \
           --set front_app "${front_app[@]}" \
           --subscribe front_app front_app_switched
