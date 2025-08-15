#!/bin/bash

media=(
  icon="󰎆"
  icon.color=$MEDIA_ICON_COLOR
  icon.font.size=16
  label.max_chars=40
  label.font.size=13
  script="$PLUGIN_DIR/media.sh"
  click_script="$PLUGIN_DIR/media_click.sh"
  updates=on
  drawing=off
  scroll_texts=off
  update_freq=2
)

sketchybar --add item media center \
           --set media "${media[@]}"
