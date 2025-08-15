#!/bin/bash

source "$CONFIG_DIR/helpers/constants.sh"

LOCK_FILE="/tmp/sketchybar_media_toggle.lock"

toggle_playback() {
  if command -v media-control >/dev/null 2>&1; then
    media-control toggle-play-pause
  fi
}

case "$BUTTON" in
  "left") toggle_playback ;;
esac
