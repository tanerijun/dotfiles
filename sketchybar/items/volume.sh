#!/bin/sh

volume_slider=(
    script="$PLUGIN_DIR/volume.sh"
    updates=on
    label.drawing=off
    icon.drawing=off
    slider.highlight_color=$VOLUME_SLIDER_HIGHLIGHT_COLOR
    slider.background.height=5
    slider.background.corner_radius=3
    slider.background.color=$VOLUME_SLIDER_BG_COLOR
    slider.knob="󰄯"
    slider.knob.drawing=on
    slider.knob.color=$VOLUME_SLIDER_KNOB_COLOR
    slider.width=0
)

volume_icon=(
    click_script="$PLUGIN_DIR/volume_click.sh"
    icon="󰕾"
    icon.font.size=16
    padding_right=0
    label.padding_right=0
)

sketchybar --add slider volume right            \
           --set volume "${volume_slider[@]}"   \
           --subscribe volume volume_change     \
                              mouse.clicked     \
           --add item volume_icon right         \
           --set volume_icon "${volume_icon[@]}"

sketchybar --trigger volume_change
