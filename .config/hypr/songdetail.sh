#!/bin/bash

title=$(playerctl metadata --format '{{title}}')

if [ ${#title} -gt 30 ]; then
  title=${title:0:30}"..."
fi

artist=$(playerctl metadata --format '{{artist}}')

if [ ${#artist} -gt 30 ]; then
  artist=${artist:0:30}"..."
fi

icon=$(playerctl -p $(playerctl -l) metadata --format '{{icon}}')

case $(playerctl -l) in
  spotify)
    icon=""
    ;;
  vlc)
    icon="󰕼"
    ;;
  firefox*)
    icon=""
    ;;
  *)
    icon=""
    ;;
esac

if [ -n "$artist" ] || [ -n "$title" ]; then
  echo "$artist  $icon  $title"
fi
