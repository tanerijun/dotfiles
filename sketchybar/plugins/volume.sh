#!/bin/bash

source "$CONFIG_DIR/helpers/constants.sh"

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

    if [ "$INFO" -gt 85 ]; then
        COLOR=$VOLUME_ICON_COLOR_RED
    elif [ "$INFO" -gt 60 ]; then
        COLOR=$VOLUME_ICON_COLOR_ORANGE
    elif [ "$INFO" -gt 30 ]; then
        COLOR=$VOLUME_ICON_COLOR_YELLOW
    else
        COLOR=$VOLUME_ICON_COLOR_GREEN
    fi

    sketchybar --set volume_icon icon="$ICON" \
                               icon.color="$COLOR" \
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
