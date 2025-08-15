#!/bin/sh

source "$CONFIG_DIR/helpers/constants.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

if [[ "$CHARGING" != "" ]]; then
  # Charging icons
  case "${PERCENTAGE}" in
    9[0-9]|100) ICON="󰂅"  # 90-100% charging
    ;;
    8[0-9]) ICON="󰂋"      # 80-89% charging
    ;;
    7[0-9]) ICON="󰂊"      # 70-79% charging
    ;;
    6[0-9]) ICON="󰢞"      # 60-69% charging
    ;;
    5[0-9]) ICON="󰂉"      # 50-59% charging
    ;;
    4[0-9]) ICON="󰢝"      # 40-49% charging
    ;;
    3[0-9]) ICON="󰂈"      # 30-39% charging
    ;;
    2[0-9]) ICON="󰂇"      # 20-29% charging
    ;;
    1[0-9]) ICON="󰂆"      # 10-19% charging
    ;;
    *) ICON="󰢜"           # 0-9% charging
  esac
else
  # Normal battery icons
  case "${PERCENTAGE}" in
    9[0-9]|100) ICON="󰁹"  # 90-100%
    ;;
    8[0-9]) ICON="󰂂"      # 80-89%
    ;;
    7[0-9]) ICON="󰂁"      # 70-79%
    ;;
    6[0-9]) ICON="󰂀"      # 60-69%
    ;;
    5[0-9]) ICON="󰁿"      # 50-59%
    ;;
    4[0-9]) ICON="󰁾"      # 40-49%
    ;;
    3[0-9]) ICON="󰁽"      # 30-39%
    ;;
    2[0-9]) ICON="󰁼"      # 20-29%
    ;;
    1[0-9]) ICON="󰁻"      # 10-19%
    ;;
    *) ICON="󰁺"           # 0-9%
  esac
fi

if [[ "$CHARGING" != "" ]]; then
  # Always green when charging
  ICON_COLOR=$BATTERY_GREEN
else
  # Color based on battery level when not charging
  if [ "$PERCENTAGE" -ge 50 ]; then
    ICON_COLOR=$BATTERY_GREEN
  elif [ "$PERCENTAGE" -ge 30 ]; then
    ICON_COLOR=$BATTERY_YELLOW
  else
    ICON_COLOR=$BATTERY_RED
  fi
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" icon.color="$ICON_COLOR" label="${PERCENTAGE}%"
