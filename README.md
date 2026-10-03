# rad-14-wm-setup

## What is rad-14-wm-setup?
This setup can also be described as the dotfiles of a UI/UX designer and researcher who is starting to fall in love with Linux. There are 3 types of DE/WM included in these dotfiles:
- GNOME
- Hyprland (Serpantine & end4-pc)
- driftwm

This setup has helped me work on UI/UX design projects for 4 months. I created this as a backup so I can easily reinstall this setup if my laptop breaks or if I get a new one.

If you want to experience my custom setup, feel free to install it!

## Features
- Carefully crafted environments tailored for UI/UX design workflows.
- Optional installation for a suite of productivity and design applications, including:
  - Ferdium, Zen Browser, Brave Browser
  - Obsidian
  - Spotify / Spicetify
  - Figma Linux
  - Allusion
  - Vesktop
  - Stirling PDF

## Installation

**Prerequisites:**
- A Linux distribution (Arch, Fedora, Debian/Ubuntu, or openSUSE).
- Your distro's package manager (`yay`, `pacman`, `dnf`, `apt`, or `zypper`).
- `flatpak` (Optional, but highly recommended for installing the pre-installed apps across different distros).

**Steps:**

1. Clone this repository:
   ```bash
   git clone <your-repository-url>
   cd rad-14-wm-setup
   ```

2. Make the installation script executable:
   ```bash
   chmod +x install.sh
   ```

3. Run the installation script:
   ```bash
   ./install.sh
   ```
   *Note: During the installation process, the script will ask if you want to install the pre-installed applications for design and productivity.*

## Backup

If you make changes to your configurations and want to update this repository, you can use the provided backup script:

```bash
chmod +x backup.sh
./backup.sh
```
