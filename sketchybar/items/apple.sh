#!/bin/bash

POPUP_OFF='sketchybar --set apple.logo popup.drawing=off'
POPUP_CLICK_SCRIPT='sketchybar --set $NAME popup.drawing=toggle'

apple_logo=(
  icon=""
  icon.color="$BAR_LABEL_COLOR"
  icon.font.style="Bold"
  icon.font.size="22"
  padding_right=6
  y_offset=1
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
)

apple_prefs=(
  icon=""
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
  padding_left=10
  padding_right=10
)

apple_activity=(
  icon=""
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
  padding_left=10
  padding_right=10
)

apple_lock=(
  icon="󰌾"
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
  padding_left=10
  padding_right=10
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"
