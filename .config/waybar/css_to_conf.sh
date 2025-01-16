#!/bin/bash

HYPR_PATH="/home/charlie/.config/hypr"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.css>"
    exit 1
fi

input_file="$1"
bare_input_file=$(basename "$1")

output_file="$HYPR_PATH/colorschemes/${bare_input_file%.css}.conf"

while IFS= read -r line; do

    if [[ $line =~ @define-color\ ([^ ]+)\ ([^;]+) ]]; then
        color_name="${BASH_REMATCH[1]}"
        color_value="${BASH_REMATCH[2]# }"

        if [[ $color_value =~ ^#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$ ]]; then
            r="${color_value:1:2}"
            g="${color_value:3:2}"
            b="${color_value:5:2}"

            r_dec=$((16#$r))
            g_dec=$((16#$g))
            b_dec=$((16#$b))

            echo "\$$color_name = rgb($r_dec,$g_dec,$b_dec)" >> "$output_file"
        fi
    fi
done < "$input_file"
