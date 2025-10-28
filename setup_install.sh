#!/usr/bin/env bash
# -------------------------------------------------------------------
# setup_install.sh — Install QSOL-IMC / Podcaster + Dev Environment
# Author: Trent Slade / QSOLKCB
# -------------------------------------------------------------------

PKG_LIST=(
  base base-devel git curl wget
  clang cmake make ninja gdb llvm
  python python-pip python-virtualenv
  go rust npm nodejs
  pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber
  alsa-utils alsa-plugins pavucontrol helvum easyeffects
  obs-studio vokoscreen-ng kdenlive shotcut
  ffmpeg sox speexdsp vlc mpv quodlibet spek gnuplot
  sof-firmware alsa-firmware alsa-ucm-conf
  jupyterlab
)

echo "==> Installing required packages..."
sudo pacman -S --needed --noconfirm "${PKG_LIST[@]}"

# Optional: install Miniforge + Jupyter env
CONDA_DIR="$HOME/miniforge3"
if [[ ! -d "$CONDA_DIR" ]]; then
  echo "==> Installing Miniforge..."
  wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O /tmp/miniforge.sh
  bash /tmp/miniforge.sh -b -p "$CONDA_DIR"
  eval "$("$CONDA_DIR/bin/conda" shell.bash hook)"
  conda init bash
  conda config --set auto_activate_base false
fi

echo "==> Creating qsolimc environment..."
eval "$("$CONDA_DIR/bin/conda" shell.bash hook)"
conda create -y -n qsolimc python=3.12 jupyterlab numpy scipy matplotlib pandas sympy ipywidgets

echo "✅ Installation finished."
echo "Activate with:  conda activate qsolimc"
echo "Launch Jupyter: jupyter lab"
