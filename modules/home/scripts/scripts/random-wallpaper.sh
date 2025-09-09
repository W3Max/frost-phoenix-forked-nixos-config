#!/usr/bin/env bash

wallpaper_path="$HOME/Pictures/wallpapers"
wallpapers_folder="$HOME/Pictures/wallpapers/others"

current_wallpaper=$(readlink "$wallpaper_path/wallpaper" 2> /dev/null)
current_wallpaper_name="$(basename "$current_wallpaper")"

mapfile -t wallpaper_list < <(find "$wallpapers_folder" -maxdepth 1 -type f -printf '%f\n')
wallpaper_count=${#wallpaper_list[@]}

while true; do
    wallpaper_name="${wallpaper_list[RANDOM % wallpaper_count]}"

    if [[ "$wallpaper_name" != "$current_wallpaper_name" ]]; then
        break
    fi
done

ln -sf "$wallpapers_folder/$wallpaper_name" "$wallpaper_path/wallpaper"
wall-change "$wallpaper_path/wallpaper" &
