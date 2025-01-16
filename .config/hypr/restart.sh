_ps=(waybar rofi swaync)
for _prs in "${_ps[@]}"; do
    if pidof "${_prs}" >/dev/null; then
        pkill "${_prs}"
    fi
done

sleep 0.1

waybar &
swaync > /dev/null 2>&1 &

pids=$(pidof kitty nvim swaync)

for pid in $pids; do
  kill -SIGUSR1 '$pid'
done

exit 0
