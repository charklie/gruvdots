#!/usr/bin/env sh

CHOSEN=$(printf "Dracula\nGruvbox (Dark)\nKanagawa\nTokyo Night (Storm)\nRosé Pine" | rofi -dmenu)

case "$CHOSEN" in
"Dracula") "$HOME/.config/waybar/switch_colorscheme.sh dracula" dracula ;;
"Gruvbox (Dark)") "$HOME/.config/waybar/switch_colorscheme.sh" gruvbox ;;
"Tokyo Night (Storm)") "$HOME/.config/waybar/switch_colorscheme.sh" tokyonight ;;
"Rosé Pine") "$HOME/.config/waybar/switch_colorscheme.sh" rosepine ;;
"Kanagawa") "$HOME/.config/waybar/switch_colorscheme.sh" kanagawa ;;
esac
