WAYBAR_PATH="$HOME/.config/waybar"
ROFI_PATH="$HOME/.config/rofi"
HYPR_PATH="$HOME/.config/hypr"

COLORSCHEMES=("gruvbox_dark" "dracula" "tokyonight" "rosepine" "kanawaga" "kanagawa" "gruvbox_light")

ROSEPINE_WALL=$HOME/.gruvdots/walls/dracula-balcony.png
DRACULA_WALL=$HOME/.gruvdots/walls/dracula-black-hole.png
GRUVBOX_DARK_WALL=$HOME/.gruvdots/walls/forest-4.jpg
GRUVBOX_LIGHT_WALL=$HOME/.gruvdots/walls/gruvbox_Balcony_wifuless.png
TOKYONIGHT_WALL=$HOME/.gruvdots/walls/tokyonight-mountains.jpg
KANAGAWA_WALL=$HOME/.gruvdots/walls/kanagawa-balcony.png

if [[ " ${COLORSCHEMES[*]} " =~ $1 ]]; then
  rm "$WAYBAR_PATH/colorscheme.css"
  rm "$ROFI_PATH/colorscheme.rasi"
  rm "$WAYBAR_PATH/active_colorscheme.txt"
  touch "$WAYBAR_PATH/active_colorscheme.txt"
else
  echo "Argument 1 wrong, expected a colorscheme, found \"$1\""
fi

case "$1" in
"gruvbox_dark")
  ln -s "$WAYBAR_PATH/colorschemes/gruvbox-dark.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/gruvbox_dark.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Gruvbox\ Dark
  gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Material-Dark-HIDPI"
  echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$GRUVBOX_DARK_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
"gruvbox_light")
  ln -s "$WAYBAR_PATH/colorschemes/gruvbox-light.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/gruvbox_light.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Gruvbox\ Light
  gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Light"
  echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$GRUVBOX_LIGHT_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
"dracula")
  ln -s "$WAYBAR_PATH/colorschemes/dracula.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/dracula.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Dracula
  gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
  echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$DRACULA_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
"tokyonight")
  ln -s "$WAYBAR_PATH/colorschemes/tokyonight_storm.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/tokyonight.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Tokyo\ Night\ Moon
  gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"
  echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$TOKYONIGHT_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
"rosepine")
  ln -s "$WAYBAR_PATH/colorschemes/rosepine.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/rosepine.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Rosé\ Pine
  gsettings set org.gnome.desktop.interface gtk-theme "rose-pine-gtk"
  echo "rose-pine-main" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$ROSEPINE_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
"kanagawa" | "kanawaga") # Often misspelt, just add both
  ln -s "$WAYBAR_PATH/colorschemes/kanagawa.css" "$WAYBAR_PATH/colorscheme.css"
  ln -s "$ROFI_PATH/colorschemes/kanagawa.rasi" "$ROFI_PATH/colorscheme.rasi"
  kitten themes Kanagawa
  gsettings set org.gnome.desktop.interface gtk-theme "Kanagawa-Borderless"
  echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt"
  swaybg -i "$KANAGAWA_WALL"
  "$HYPR_PATH/restart.sh"
  ;;
esac
