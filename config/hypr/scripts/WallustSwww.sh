#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Wallust Colors for current wallpaper

# Get wallpaper path from argument
wallpaper_path="$1"

# Verify wallpaper path exists
if [[ -z "$wallpaper_path" ]] || [[ ! -f "$wallpaper_path" ]]; then
  echo "Error: Invalid wallpaper path: $wallpaper_path"
  exit 1
fi

# symlink the wallpaper to the location Rofi can access
ln -sf "$wallpaper_path" "$HOME/.config/rofi/.current_wallpaper"

# copy the wallpaper for wallpaper effects
cp -r "$wallpaper_path" "$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"

# execute wallust
wallust run "$wallpaper_path" -s &
