source "$CONFIG_DIR/helpers/constants.sh"

reload_workspace_icon() {
  if [ -z "$1" ]; then
    return
  fi

  apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

  icon_strip=" "
  if [ "${apps}" != "" ]; then
    while read -r app
    do
      icon_strip+=" $($CONFIG_DIR/helpers/icon_map_fn.sh "$app")"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi

  sketchybar --animate sin 10 --set space.$1 label="$icon_strip"
}

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  if [ -z "$AEROSPACE_FOCUSED_WORKSPACE" ]; then
    exit 0
  fi

  CURRENT_FOCUSED=$(aerospace list-workspaces --focused)

  # Build single batch command to avoid race conditions
  CMD="sketchybar"

  # Unhighlight all workspaces
  for workspace in $(aerospace list-workspaces --all); do
    CMD="$CMD --set space.$workspace icon.highlight=false label.highlight=false background.border_color=$WORKSPACE_ITEM_BORDER_COLOR"
  done

  # Highlight only the current one
  CMD="$CMD --set space.$CURRENT_FOCUSED icon.highlight=true label.highlight=true background.border_color=$WORKSPACE_ITEM_BORDER_HIGHLIGHT_COLOR"

  # Execute all changes in one batch
  eval $CMD

  # Update icons
  if [ -n "$AEROSPACE_PREV_WORKSPACE" ]; then
    reload_workspace_icon "$AEROSPACE_PREV_WORKSPACE"
  fi
  reload_workspace_icon "$CURRENT_FOCUSED"

  # Handle display logic
  AEROSPACE_FOCUSED_MONITOR=$(aerospace list-monitors --focused | awk '{print $1}')
  AEROSPACE_WORKSPACE_FOCUSED_MONITOR=$(aerospace list-workspaces --monitor focused --empty no)
  AEROSPACE_EMPTY_WORKSPACE=$(aerospace list-workspaces --monitor focused --empty)

  for i in $AEROSPACE_WORKSPACE_FOCUSED_MONITOR; do
    sketchybar --set space.$i display=$AEROSPACE_FOCUSED_MONITOR
  done

  for i in $AEROSPACE_EMPTY_WORKSPACE; do
    sketchybar --set space.$i display=0
  done

  sketchybar --set space.$CURRENT_FOCUSED display=$AEROSPACE_FOCUSED_MONITOR
fi

if [ "$SENDER" = "front_app_switched" ]; then
  CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)
  reload_workspace_icon "$CURRENT_WORKSPACE"
fi

if [ "$SENDER" = "window_detected" ]; then
  CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)
  reload_workspace_icon "$CURRENT_WORKSPACE"
fi
