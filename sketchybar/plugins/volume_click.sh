#!/bin/bash

WIDTH=100

detail_on() {
    sketchybar --animate tanh 30 --set volume slider.width=$WIDTH
    sketchybar --set volume_icon label.padding_right=3
}

detail_off() {
    sketchybar --animate tanh 30 --set volume slider.width=0
    sketchybar --set volume_icon label.padding_right=0
}

toggle_detail() {
    INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")
    if [ "$INITIAL_WIDTH" -eq "0" ]; then
        detail_on
    else
        detail_off
    fi
}

toggle_devices() {
    which SwitchAudioSource >/dev/null || exit 0
    source "$CONFIG_DIR/helpers/constants.sh"

    sketchybar --remove '/volume.device\.*/' 2>/dev/null

    args=(--set "$NAME" popup.drawing=toggle)
    COUNTER=0
    CURRENT="$(SwitchAudioSource -t output -c)"
    while IFS= read -r device; do
        COLOR=$VOLUME_OUTPUT_POPUP_LABEL_COLOR
        if [ "${device}" = "$CURRENT" ]; then
        COLOR=$VOLUME_OUTPUT_POPUP_SELECTED_LABEL_COLOR
        fi
        # Not sure why the right side seems narrower, hence the larger padding_right
        args+=(--add item volume.device.$COUNTER popup."$NAME" \
               --set volume.device.$COUNTER label="${device}" \
                                            label.color="$COLOR" \
                                            padding_left=10 \
                                            padding_right=15 \
                     click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\.*/ label.color=$NORD12 --set \$NAME label.color=$NORD11 --set $NAME popup.drawing=off")
        COUNTER=$((COUNTER+1))
    done <<< "$(SwitchAudioSource -a -t output)"

    sketchybar -m "${args[@]}" > /dev/null
}

if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
  toggle_devices
else
  toggle_detail
fi
