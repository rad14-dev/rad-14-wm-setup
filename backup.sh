#!/bin/bash

BACKUP_DIR="$(dirname "$(realpath "$0")")/config"
CONFIG_DIR="$HOME/.config"

echo "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# List of directories to backup
DIRECTORIES=(
    "hypr"
    "hypr-piCoulomb"
    "kitty"
    "rofi"
    "swaync"
    "swayosd"
    "waybar"
)

for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$CONFIG_DIR/$dir" ]; then
        echo "Backing up $dir..."
        cp -r "$CONFIG_DIR/$dir" "$BACKUP_DIR/"
    else
        echo "Warning: $CONFIG_DIR/$dir does not exist, skipping."
    fi
done

# Backup wallpapers
WALLPAPER_DIR="$(dirname "$(realpath "$0")")/my wallpaper"
mkdir -p "$WALLPAPER_DIR"
if [ -d "$HOME/Pictures/Wallpapers" ]; then
    echo "Backing up wallpapers from $HOME/Pictures/Wallpapers..."
    cp -r "$HOME/Pictures/Wallpapers/"* "$WALLPAPER_DIR/" 2>/dev/null || true
else
    echo "Warning: $HOME/Pictures/Wallpapers does not exist, skipping wallpaper backup."
fi

echo "Backup complete! You can find your configs in $BACKUP_DIR"
