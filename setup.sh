#!/usr/bin/env bash
# QSOL System Verification — Audio / GPU / Env Snapshot
# Used after fullstack.sh completes

set -euo pipefail
LOG_DIR="$HOME/system_health"
mkdir -p "$LOG_DIR"

echo "==> 🌏 Updating mirrors..."
sudo reflector --country 'Australia' --age 12 --latest 10 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Sy --needed --noconfirm archlinux-keyring

# -------------------------------------------------------------------
#  Phase 3 – Service Verification (PipeWire, GPU, Steam, NVIDIA)
# -------------------------------------------------------------------
echo "==> 🎧 Checking audio services..."
systemctl --user status pipewire pipewire-pulse wireplumber >"$LOG_DIR/audio_services.txt" 2>&1
pactl info | grep "Server Name" >>"$LOG_DIR/audio_services.txt" 2>&1 || true

echo "==> 🎮 Checking GPU stack..."
if command -v nvidia-smi >/dev/null; then
  nvidia-smi >"$LOG_DIR/nvidia_smi.txt" 2>&1
else
  echo "No NVIDIA GPU detected" >"$LOG_DIR/nvidia_smi.txt"
fi
glxinfo | grep "OpenGL renderer" >"$LOG_DIR/glxinfo.txt" 2>/dev/null || echo "Mesa/AMD path active" >"$LOG_DIR/glxinfo.txt"

# -------------------------------------------------------------------
#  Phase 4 – Environment Snapshot
# -------------------------------------------------------------------
echo "==> 📦 Python / Jupyter environments..."
if command -v python >/dev/null; then
  python --version >"$LOG_DIR/python_version.txt"
fi

if command -v jupyter >/dev/null; then
  jupyter --paths >"$LOG_DIR/jupyter_paths.txt"
fi

echo "==> 🧬 Virtual environments..."
if [ -d "$HOME/envs" ]; then
  ls -1 "$HOME/envs" >"$LOG_DIR/venv_list.txt"
fi

# -------------------------------------------------------------------
#  Phase 5 – Optional maintenance
# -------------------------------------------------------------------
read -rp "Run full system update and cleanup now? [y/N]: " UPDATE
if [[ "$UPDATE" =~ ^[Yy]$ ]]; then
  echo "==> 🔄 Updating everything..."
  sudo pacman -Syu --noconfirm
  if command -v yay >/dev/null; then
    yay -Syu --devel --timeupdate --noconfirm
  fi
  echo "==> 🧹 Cleaning cache and logs..."
  sudo pacman -Sc --noconfirm
  sudo journalctl --vacuum-time=10d
fi

echo "✅ Verification complete."
echo "Logs saved in $LOG_DIR"
echo "To restore package list baseline:"
echo "   pacman -S --needed - < $LOG_DIR/installed_pkglist.txt"
