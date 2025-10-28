#!/usr/bin/env bash
# -------------------------------------------------------------------
# setup_dryrun.sh — Simulate QSOL-IMC / Podcaster + Dev Environment
# Author: Trent Slade / QSOLKCB
# -------------------------------------------------------------------

LOG_DIR="$HOME/system_specs"
mkdir -p "$LOG_DIR"

echo "==> Collecting system specs..."
lscpu > "$LOG_DIR/cpu.txt"
lspci -nnk > "$LOG_DIR/pci_devices.txt"
lsusb > "$LOG_DIR/usb.txt"
lspci | grep -i audio > "$LOG_DIR/audio.txt"
lsmod | grep snd > "$LOG_DIR/audio_modules.txt"
free -h > "$LOG_DIR/memory.txt"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT > "$LOG_DIR/storage.txt"
pacman -Qqe > "$LOG_DIR/pre_setup_pkglist.txt"

echo "==> Checking current audio stack..."
systemctl --user status pipewire pipewire-pulse wireplumber > "$LOG_DIR/audio_services.txt" 2>&1
pactl info | grep "Server Name" >> "$LOG_DIR/audio_services.txt" 2>&1
echo "✅ System logs saved to $LOG_DIR"

echo "==> Simulating package installation..."
sudo pacman -S --print \
  base base-devel git curl wget \
  clang cmake make ninja gdb llvm \
  python python-pip python-virtualenv \
  go rust npm nodejs \
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber \
  alsa-utils alsa-plugins pavucontrol helvum easyeffects \
  obs-studio vokoscreen-ng kdenlive shotcut \
  ffmpeg sox speexdsp vlc mpv quodlibet spek gnuplot \
  sof-firmware alsa-firmware alsa-ucm-conf \
  jupyterlab
echo "==> Dry-run complete — no packages installed."
