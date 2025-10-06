#!/usr/bin/env bash
# Backup and restore user-installed packages on Arch Linux (including AUR)
# Requires: paru

set -euo pipefail

BACKUP_DIR="${HOME}/arch_pkg_backup"
PKG_FILE="${BACKUP_DIR}/repo-packages.txt"
AUR_FILE="${BACKUP_DIR}/aur-packages.txt"

usage() {
    echo "Usage:"
    echo "  $0 backup   - Save a list of manually installed packages (repo + AUR)"
    echo "  $0 restore  - Reinstall packages from saved lists using paru"
    exit 1
}

check_paru() {
    if ! command -v paru &>/dev/null; then
        echo "Error: paru is not installed. Please install paru first."
        exit 1
    fi
}

backup_packages() {
    mkdir -p "$BACKUP_DIR"

    echo "Backing up official repo packages..."
    pacman -Qqe | grep -vx "$(pacman -Qqm)" > "$PKG_FILE"

    echo "Backing up AUR packages..."
    pacman -Qqm > "$AUR_FILE"

    echo
    echo "✅ Backup complete!"
    echo "Repo packages: $PKG_FILE"
    echo "AUR packages:  $AUR_FILE"
}

restore_packages() {
    check_paru

    if [[ ! -f "$PKG_FILE" && ! -f "$AUR_FILE" ]]; then
        echo "Error: No backup files found in $BACKUP_DIR"
        exit 1
    fi

    echo "Restoring official repo packages..."
    if [[ -f "$PKG_FILE" ]]; then
        sudo pacman -S --needed - < "$PKG_FILE"
    fi

    echo
    echo "Restoring AUR packages using paru..."
    if [[ -f "$AUR_FILE" ]]; then
        paru -S --needed - < "$AUR_FILE"
    fi

    echo
    echo "✅ Restore complete!"
}

if [[ $# -ne 1 ]]; then
    usage
fi

case "$1" in
    backup)
        backup_packages
        ;;
    restore)
        restore_packages
        ;;
    *)
        usage
        ;;
esac
