#!/usr/bin/env bash
# QSOL Arch Bootstrap
# Small is Beautiful, Fast is Holy

set -Eeuo pipefail
LOG="$HOME/setup.log"
trap 'echo "❌ Error on line $LINENO" | tee -a "$LOG"' ERR

log()  { echo -e "\033[1;34m==> $1\033[0m" | tee -a "$LOG"; }
ok()   { echo -e "\033[1;32m✅ $1\033[0m" | tee -a "$LOG"; }

# --- SYSTEM INFO ---
log "Collecting system specs..."
mkdir -p "$HOME/system_specs"
fastfetch --load-config none > "$HOME/system_specs/fastfetch.txt" 2>&1 || true
lspci > "$HOME/system_specs/lspci.txt" 2>/dev/null || true
lsusb > "$HOME/system_specs/lsusb.txt" 2>/dev/null || true
ok "System specs collected."

# --- DEPENDENCIES ---
log "Installing base utilities..."
sudo pacman -S --needed --noconfirm usbutils fastfetch wget git curl base-devel || true
ok "Base utilities ensured."

# --- AUDIO STACK ---
log "Checking audio stack..."
if ! systemctl --user is-active --quiet pipewire; then
  log "PipeWire not active — enabling."
  systemctl --user enable --now pipewire pipewire-pulse wireplumber || true
else
  ok "PipeWire active."
fi

# --- MULTIMEDIA (AUR SUPPORT) ---
log "Ensuring AUR helper..."
if command -v paru &>/dev/null; then AUR=paru
elif command -v yay &>/dev/null; then AUR=yay
else
  log "Installing paru..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru && cd /tmp/paru && makepkg -si --noconfirm
  AUR=paru
fi
ok "AUR helper ready: $AUR"

log "Installing multimedia tools (vokoscreen-ng, spek)..."
$AUR -S --needed --noconfirm vokoscreen-ng spek-git || log "Skipped missing AUR targets."
ok "Multimedia stage complete."

# --- DEVELOPMENT TOOLS ---
log "Installing dev tools..."
sudo pacman -S --needed --noconfirm python python-pip rust go docker jq neovim || true
ok "Dev tools installed."

# --- CLEANUP ---
log "Cleaning package cache..."
sudo pacman -Sc --noconfirm || true
ok "Setup complete. Log stored at $LOG"
