#!/bin/bash

source "$CONFIG_DIR/helpers/constants.sh"

update_mode_display() {
  CURRENT_MODE=$(aerospace list-modes --current)
  MODE_LETTER=$(echo "$CURRENT_MODE" | cut -c1 | tr '[:lower:]' '[:upper:]')

  sketchybar --set $NAME icon="$MODE_LETTER"
}

case "$SENDER" in
  "aerospace_mode_change") update_mode_display
  ;;
  *) update_mode_display
  ;;
esac
