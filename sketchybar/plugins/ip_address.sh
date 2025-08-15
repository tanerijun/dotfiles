#!/bin/sh

source "$CONFIG_DIR/helpers/constants.sh"

IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)
IS_VPN=$(scutil --nwi | grep -E 'utun|ppp' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
	ICON=
	ICON_COLOR=$NETWORK_VPN_ICON_COLOR
	LABEL=$IP_ADDRESS
elif [[ $IP_ADDRESS != "" ]]; then
	ICON=
	ICON_COLOR=$NETWORK_WIFI_ICON_COLOR
	LABEL=$IP_ADDRESS
else
	ICON=
	ICON_COLOR=$NETWORK_NOT_CONNECTED_ICON_COLOR
	LABEL="Offline"
fi

sketchybar --set $NAME icon="$ICON" icon.color="$ICON_COLOR" label="$LABEL"
