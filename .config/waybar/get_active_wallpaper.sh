#!/bin/bash

WAYBAR_DIR="$HOME/.config/waybar"

echo $($WAYBAR_DIR/switch_colorscheme.sh --get-wallpaper $(cat $WAYBAR_DIR/active_colorscheme.txt))
