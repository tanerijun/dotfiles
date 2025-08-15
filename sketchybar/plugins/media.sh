#!/bin/bash

source "$CONFIG_DIR/helpers/constants.sh"

truncate_text() {
  local text="$1"
  local max_length=30

  if [ ${#text} -gt $max_length ]; then
    echo "${text:0:$max_length}..."
  else
    echo "$text"
  fi
}

update_media() {
  # Quick exit if media-control not available
  command -v media-control >/dev/null 2>&1 || { sketchybar --set "$NAME" drawing=off; return; }

  # Get media info (this is fast ~10-20ms)
  MEDIA_JSON=$(media-control get 2>/dev/null) || { sketchybar --set "$NAME" drawing=off; return; }

  # Quick parsing (using faster method)
  TITLE=$(echo "$MEDIA_JSON" | jq -r '.title // empty')
  [ -z "$TITLE" ] || [ "$TITLE" = "null" ] && { sketchybar --set "$NAME" drawing=off; return; }

  ARTIST=$(echo "$MEDIA_JSON" | jq -r '.artist // empty')
  BUNDLE_ID=$(echo "$MEDIA_JSON" | jq -r '.bundleIdentifier // empty')
  PLAYBACK_RATE=$(echo "$MEDIA_JSON" | jq -r '.playbackRate // 0')

  # Set icon and color
  case "$BUNDLE_ID" in
    "com.spotify.client") ICON="󰓇" ;;
    "com.apple.Music") ICON="󰎆" ;;
    "com.apple.Safari"|"com.google.Chrome") ICON="󰖟" ;;
    *) ICON="󰎆" ;;
  esac

  if [ "$PLAYBACK_RATE" != "0" ] && [ "$PLAYBACK_RATE" != "0.0" ]; then
    ICON_COLOR=$MEDIA_ICON_PLAYING_COLOR
  else
    ICON_COLOR=$MEDIA_ICON_COLOR
  fi

  # Format text
  if [ -n "$ARTIST" ] && [ "$ARTIST" != "null" ]; then
    MEDIA_TEXT="$TITLE - $ARTIST"
  else
    MEDIA_TEXT="$TITLE"
  fi

  MEDIA_TEXT=$(truncate_text "$MEDIA_TEXT")

  sketchybar --set "$NAME" icon="$ICON" icon.color="$ICON_COLOR" label="$MEDIA_TEXT" drawing=on
}

case "$SENDER" in
  *) update_media ;;
esac
