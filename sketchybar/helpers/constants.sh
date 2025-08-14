#!/bin/bash

# AARRGGBB alpha conversion
# | Opacity | Hex (AA) | Example (`0xAARRGGBB`) |
# |---------|----------|------------------------|
# | 5%      | `0D`     | `0x0D2E3440`           |
# | 10%     | `1A`     | `0x1A2E3440`           |
# | 15%     | `26`     | `0x262E3440`           |
# | 20%     | `33`     | `0x332E3440`           |
# | 25%     | `40`     | `0x402E3440`           |
# | 30%     | `4D`     | `0x4D2E3440`           |
# | 35%     | `59`     | `0x592E3440`           |
# | 40%     | `66`     | `0x662E3440`           |
# | 45%     | `73`     | `0x732E3440`           |
# | 50%     | `80`     | `0x802E3440`           |
# | 55%     | `8C`     | `0x8C2E3440`           |
# | 60%     | `99`     | `0x992E3440`           |
# | 65%     | `A6`     | `0xA62E3440`           |
# | 70%     | `B3`     | `0xB32E3440`           |
# | 75%     | `BF`     | `0xBF2E3440`           |
# | 80%     | `CC`     | `0xCC2E3440`           |
# | 85%     | `D9`     | `0xD92E3440`           |
# | 90%     | `E6`     | `0xE62E3440`           |
# | 95%     | `F2`     | `0xF22E3440`           |
# | 100%    | `FF`     | `0xFF2E3440`           |

##### Nord Colors in 0xAARRGGBB #####
# https://www.nordtheme.com/docs/colors-and-palettes
NORD0="0xFF2E3440" # Darkest background
NORD1="0xFF3B4252" # Elevated/Focused background, border, shadow
NORD2="0xFF434C5E" # Active object background
NORD3="0xFF4C566A" # Brightest shade of NORD0
NORD4="0xFFD8DEE9" # Light text
NORD5="0xFFE5E9F0" # Brighter
NORD6="0xFFECEFF4" # Brightest
NORD7="0xFF8FBCBB" # Secondary color
NORD8="0xFF88C0D0" # Primary color
NORD9="0xFF81A1C1" # Darkened and less saturated
NORD10="0xFF5E81AC" # Tertiary
NORD11="0xFFBF616A" # Red
NORD12="0xFFD08770" # Orange
NORD13="0xFFEBCB8B" # Yellow
NORD14="0xFFA3BE8C" # Green
NORD15="0xFFB48EAD" # Purple
TRANSPARENT="0x00000000"

export BAR_BG_COLOR="0xCC2E3440" # NORD0 with 80% opacity
export BAR_BORDER_COLOR=$NORD2
export BAR_ICON_COLOR=$NORD8
export BAR_ICON_COLOR_HIGHLIGHT=$NORD10
export BAR_LABEL_COLOR=$NORD4
export BAR_LABEL_COLOR_HIGHLIGHT=$NORD6
export BAR_POPUP_BG_COLOR="0xD93B4252" # NORD1 with 85% opacity
export BAR_POPUP_BORDER_COLOR=$NORD3
export BAR_FONT_FAMILY="Maple Mono NF CN"

export WORKSPACE_ICON_COLOR=$NORD3
export WORKSPACE_ICON_HIGHLIGHT_COLOR=$NORD8
export WORKSPACE_LABEL_COLOR=$NORD3
export WORKSPACE_LABEL_HIGHLIGHT_COLOR=$NORD4
export WORKSPACE_ITEM_BORDER_COLOR=$NORD2
export WORKSPACE_ITEM_BORDER_HIGHLIGHT_COLOR=$NORD3
export WORKSPACE_ITEM_BG_COLOR=$TRANSPARENT
