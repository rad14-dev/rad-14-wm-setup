#!/bin/bash

BACKUP_DIR="$(dirname "$(realpath "$0")")/config"
CONFIG_DIR="$HOME/.config"

# Deteksi Package Manager
if command -v yay &> /dev/null; then
    PM="yay -Syu --needed"
    APPS_PM="yay -S --needed"
    CORE_PKGS="hyprland waybar rofi kitty swaync swayosd-git"
    PREINSTALL_PKGS="ferdium-bin zen-browser-bin brave-bin obsidian spotify spicetify-cli figma-linux allusion-bin vesktop-bin stirling-pdf-bin"
elif command -v pacman &> /dev/null; then
    PM="sudo pacman -Syu --needed"
    APPS_PM="sudo pacman -S --needed"
    CORE_PKGS="hyprland waybar rofi kitty"
    PREINSTALL_PKGS="obsidian"
elif command -v dnf &> /dev/null; then
    PM="sudo dnf install -y"
    APPS_PM="sudo dnf install -y"
    CORE_PKGS="hyprland waybar rofi kitty swaync"
    PREINSTALL_PKGS=""
elif command -v apt-get &> /dev/null; then
    PM="sudo apt-get install -y"
    APPS_PM="sudo apt-get install -y"
    CORE_PKGS="hyprland waybar rofi kitty"
    PREINSTALL_PKGS=""
elif command -v zypper &> /dev/null; then
    PM="sudo zypper install -y"
    APPS_PM="sudo zypper install -y"
    CORE_PKGS="hyprland waybar rofi kitty"
    PREINSTALL_PKGS=""
else
    echo "Package manager tidak didukung secara otomatis. Silakan instal dependensi manual (hyprland, waybar, rofi, kitty)."
    PM="echo 'Melewati instalasi dependensi core...'"
    APPS_PM="echo 'Melewati instalasi...'"
    CORE_PKGS=""
    PREINSTALL_PKGS=""
fi

echo "Updating system and installing required packages..."
$PM $CORE_PKGS

# Ask user for preinstalled apps
echo ""
read -p "Apakah Anda ingin menginstal aplikasi preinstall tambahan (Ferdium, Zen Browser, Brave, Obsidian, Spotify/Spicetify, Figma Linux, Allusion, Vesktop, Stirling PDF)? [y/N] " install_apps
if [[ "$install_apps" =~ ^[Yy]$ ]]; then
    echo "Menginstal aplikasi preinstall..."
    if command -v flatpak &> /dev/null; then
        echo "Menggunakan Flatpak (direkomendasikan untuk lintas distro)..."
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak install -y flathub org.ferdium.Ferdium io.github.zen_browser.zen com.brave.Browser md.obsidian.Obsidian com.spotify.Client io.github.Figma_Linux.figma_linux com.github.alexkdeveloper.allusion dev.vencord.Vesktop
    else
        echo "Mencoba menginstal via package manager bawaan..."
        $APPS_PM $PREINSTALL_PKGS
        echo "Catatan: Beberapa aplikasi mungkin tidak tersedia di repository bawaan distro Anda. Disarankan menginstal 'flatpak'."
    fi
else
    echo "Melewati instalasi aplikasi preinstall."
fi
echo ""

echo "Restoring configurations from $BACKUP_DIR to $CONFIG_DIR..."
mkdir -p "$CONFIG_DIR"

if [ ! -d "$BACKUP_DIR" ] || [ -z "$(ls -A "$BACKUP_DIR")" ]; then
    echo "Error: Backup directory $BACKUP_DIR is empty or does not exist."
    echo "Please run backup.sh first or ensure your configs are inside the 'config' folder."
    exit 1
fi

# Restore configurations
cp -r "$BACKUP_DIR/"* "$CONFIG_DIR/"

# Restore wallpapers
WALLPAPER_DIR="$(dirname "$(realpath "$0")")/my wallpaper"
if [ -d "$WALLPAPER_DIR" ] && [ "$(ls -A "$WALLPAPER_DIR")" ]; then
    echo "Restoring wallpapers to $HOME/Pictures/Wallpapers..."
    mkdir -p "$HOME/Pictures/Wallpapers"
    cp -r "$WALLPAPER_DIR/"* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true
fi

echo "Installation and configuration restore complete!"
