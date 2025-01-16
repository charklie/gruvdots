WAYBAR_PATH="$HOME/.config/waybar"
ROFI_PATH="$HOME/.config/rofi"
HYPR_PATH="$HOME/.config/hypr"

COLORSCHEMES=("gruvbox_dark" "dracula" "tokyonight" "rosepine" "rose-pine" "kanawaga" "kanagawa" "gruvbox_light")

ROSEPINE_WALL=$HOME/.gruvdots/walls/dracula-balcony.png
DRACULA_WALL=$HOME/.gruvdots/walls/dracula-black-hole.png
GRUVBOX_DARK_WALL=$HOME/.gruvdots/walls/forest-4.jpg
GRUVBOX_LIGHT_WALL=$HOME/.gruvdots/walls/gruvbox_Balcony_wifuless.png
TOKYONIGHT_WALL=$HOME/.gruvdots/walls/tokyonight-mountains.jpg
KANAGAWA_WALL=$HOME/.gruvdots/walls/gruvbox-dark.jpg

if [ "$1" == "--get-wallpaper" ]; then
  case "$2" in
    "gruvbox_dark") $GRUVBOX_DARK_WALL;;
    "gruvbox_light") $GRUVBOX_LIGHT_WALL;;
    "dracula") $DRACULA;;
    "tokyonight") $TOKYONIGHT_WALL;;
    "rosepine" | "rose-pine") $ROSEPINE_WALL;;
    "kanagawa" | "kanawaga") $KANAGAWA_WALL;;
  esac

  exit 0
fi

if [[ " ${COLORSCHEMES[*]} " =~ $1 ]]; then
  rm "$WAYBAR_PATH/colorscheme.css"
  rm "$ROFI_PATH/colorscheme.rasi"
  rm "$HYPR_PATH/colorscheme.conf"
  rm "$WAYBAR_PATH/active_colorscheme.txt"
  touch "$WAYBAR_PATH/active_colorscheme.txt"
else
  echo "Argument 1 wrong, expected a colorscheme, found \"$1\""
fi

case "$1" in
"gruvbox_dark")
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/gruvbox_dark.css"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/gruvbox_dark.rasi"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/gruvbox_dark.conf"

  DESIRED_GTK_THEME="Gruvbox-Material-Dark-HIDPI"
  DESIRED_KITTY_THEME="Gruvbox Dark"
  DESIRED_WALLPAPER=$GRUVBOX_DARK_WALL
  ;;
"gruvbox_light")
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/gruvbox_light.css"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/gruvbox_light.rasi"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/gruvbox_light.conf"

  DESIRED_GTK_THEME="Gruvbox-Light"
  DESIRED_KITTY_THEME="Gruvbox Light"
  DESIRED_WALLPAPER=$GRUVBOX_LIGHT_WALL
  ;;
"dracula")
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/dracula.css"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/dracula.rasi"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/dracula.conf"

  DESIRED_GTK_THEME="Dracula"
  DESIRED_KITTY_THEME="Dracula"
  DESIRED_WALLPAPER=$DRACULA_WALL
  ;;
"tokyonight")
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/tokyonight_storm.css"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/tokyonight_storm.conf"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/tokyonight.rasi"

  DESIRED_GTK_THEME="Tokyonight-Dark"
  DESIRED_KITTY_THEME="Tokyo Night Moon"
  DESIRED_WALLPAPER=$TOKYONIGHT_WALL
  ;;
"rosepine" | "rose-pine")
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/rosepine.css"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/rosepine.rasi"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/rosepine.conf"

  DESIRED_GTK_THEME="rose-pine-moon-gtk"
  DESIRED_KITTY_THEME="Rosé Pine"
  DESIRED_WALLPAPER=$ROSEPINE_WALL
  ;;
"kanagawa" | "kanawaga") # Often misspelt, just add both
  THEME_CSS_FILE="$WAYBAR_PATH/colorschemes/kanagawa.css"
  THEME_CONF_FILE="$HYPR_PATH/colorschemes/kanagawa.conf"
  THEME_RASI_FILE="$ROFI_PATH/colorschemes/kanagawa.rasi"

  DESIRED_GTK_THEME="Kanagawa-Borderless"
  DESIRED_KITTY_THEME="Kanagawa"
  DESIRED_WALLPAPER=$KANAGAWA_WALL
  ;;
esac

# If Hyprland theme file doesnt exist, make it
if [ -e "$THEME_CONF_FILE" ]; then
  cd $WAYBAR_PATH
  "./css_to_conf.sh colorschemes/$(basename $THEME_CSS_FILE)"
fi

# Link the colorscheme file(s).
ln -s $THEME_CSS_FILE "$WAYBAR_PATH/colorscheme.css"
ln -s $THEME_RASI_FILE "$ROFI_PATH/colorscheme.rasi"
ln -s $THEME_CONF_FILE "$HYPR_PATH/colorscheme.conf"

# Set Kitty theme
kitty +kitten theme --cache-age=-1 $DESRIRED_KITTY_THEME &

# Set GTK Theme
gsettings set org.gnome.desktop.interface gtk-theme "$DESIRED_GTK_THEME" &

# Write theme name for neovim.
echo "$1" >>"$WAYBAR_PATH/active_colorscheme.txt" &

# Reload apps to load new theme
"$HYPR_PATH/restart.sh" &

# Set Wallpaper
swaybg -i "$DESIRED_WALLPAPER" &
