#!/bin/sh

sketchybar --add event aerospace_workspace_change

for m in $(aerospace list-monitors | awk '{print $1}'); do
  for i in $(aerospace list-workspaces --monitor $m); do
    sid=$i
    space=(
      space="$sid"
      icon="$sid"
      display=$m
      icon.color=$WORKSPACE_ICON_COLOR
      icon.highlight_color=$WORKSPACE_ICON_HIGHLIGHT_COLOR
      icon.padding_left=10
      icon.padding_right=0
      label.padding_right=20
      label.color=$WORKSPACE_LABEL_COLOR
      label.highlight_color=$WORKSPACE_LABEL_HIGHLIGHT_COLOR
      label.font="sketchybar-app-font:Regular:16.0"
      label.y_offset=-1
      background.color=$WORKSPACE_ITEM_BG_COLOR
      background.border_color=$WORKSPACE_ITEM_BORDER_COLOR
      script="$PLUGIN_DIR/space.sh"
    )

    sketchybar --add space space.$sid left \
               --set space.$sid "${space[@]}" \
               --subscribe space.$sid mouse.clicked

    apps=$(aerospace list-windows --workspace $sid | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app
      do
        icon_strip+=" $($CONFIG_DIR/helpers/icon_map_fn.sh "$app")"
      done <<< "${apps}"
    else
      icon_strip=" —"
    fi

    sketchybar --set space.$sid label="$icon_strip"
  done

  for i in $(aerospace list-workspaces --monitor $m --empty); do
    sketchybar --set space.$i display=0
  done
done

space_creator=(
  icon=""
  padding_left=10
  label.drawing=off
  icon.drawing=off # enable if front_app is enabled
  icon.font.size="12.0"
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$BAR_ICON_COLOR
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator aerospace_workspace_change
