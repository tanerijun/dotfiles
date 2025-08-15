ip_address_item=(
  script="$PLUGIN_DIR/ip_address.sh"
  update_freq=30
  background.border_width=0
  background.corner_radius=6
  background.height=24
)

sketchybar --add item ip_address right \
           --set ip_address "${ip_address_item[@]}" \
           --subscribe ip_address wifi_change
