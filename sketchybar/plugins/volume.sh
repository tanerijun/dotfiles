#!/bin/bash

WIDTH=100

volume_change() {
  case $INFO in
  [6-9][0-9]|100) ICON="󰕾"
  ;;
  [3-5][0-9]) ICON="󰖀"
  ;;
  [1-9]|[1-2][0-9]) ICON="󰕿"
  ;;
  *) ICON="󰖁"
  esac

  sketchybar --set volume_icon icon="$ICON" \
                               label="${INFO}%" \
                               label.drawing=on \
             --set volume slider.percentage="$INFO"
}

mouse_clicked() {
  osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
  "volume_change") volume_change
  ;;
  "mouse.clicked") mouse_clicked
  ;;
esac
