#!/usr/bin/env bash
# QSOL / Producer.ai — Arch Linux Fullstack Clone (CUDA 13 · RTX 3050 · GNOME)
# OptiPlex 7050 / 7090  ·  f2fs  ·  systemd-boot  ·  NVIDIA 580 driver
set -euo pipefail
ME="${SUDO_USER:-$USER}"

need() { sudo pacman -Sy --needed --noconfirm "$@"; }

echo "==> Pacman refresh"
sudo pacman -Syu --noconfirm

echo "==> Base toolchain"
need base-devel git cmake ninja pkgconf clang llvm make gdb curl wget unzip p7zip \
     neovim tmux htop nvtop ripgrep fd bat exa python python-pip python-virtualenv

echo "==> Audio stack (PipeWire + JACK bridge)"
need pipewire pipewire-pulse wireplumber pipewire-jack qjackctl alsa-utils sox ffmpeg realtime-privileges
sudo usermod -aG realtime "$ME" || true
sudo install -Dm644 /dev/stdin /etc/security/limits.d/99-realtime.conf <<'EOF'
@realtime   -   rtprio     95
@realtime   -   memlock    unlimited
EOF

echo "==> System tuning (trim + sysctl)"
need util-linux
sudo systemctl enable --now fstrim.timer
sudo install -Dm644 /dev/stdin /etc/sysctl.d/99-audio.conf <<'EOF'
vm.swappiness = 10
fs.inotify.max_user_watches = 524288
EOF
sudo sysctl --system >/dev/null

echo "==> Detect GPU and install correct drivers"
GPU=$(lspci | tr '[:upper:]' '[:lower:]')
if echo "$GPU" | grep -q 'nvidia'; then
  need nvidia nvidia-utils nvidia-settings cuda opencl-nvidia
  HAS_NVIDIA=1
else
  HAS_NVIDIA=0
  if echo "$GPU" | grep -qE 'amd|ati'; then
    need mesa-vulkan-drivers vulkan-radeon rocm-opencl-runtime
  else
    need mesa-vulkan-drivers vulkan-intel
  fi
fi

echo "==> CUDA 13 path export"
if ! grep -q /opt/cuda/bin ~/.bashrc; then
  cat >> ~/.bashrc <<'EOF'

# CUDA 13 toolkit
export PATH=/opt/cuda/bin:$PATH
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
EOF
fi

echo "==> Low-latency PipeWire config"
mkdir -p "$HOME/.config/pipewire/pipewire.conf.d"
cat > "$HOME/.config/pipewire/pipewire.conf.d/99-lowlatency.conf" <<'EOF'
context.properties = {
    default.clock.rate          = 48000
    default.clock.allowed-rates = [ 48000 ]
    default.clock.quantum       = 128
    default.clock.min-quantum   = 64
    default.clock.max-quantum   = 256
}
EOF
systemctl --user enable --now pipewire pipewire-pulse wireplumber || true

echo "==> CPU governor (performance)"
need cpupower
sudo cpupower frequency-set -g performance || true

echo "==> Python 3.13 GPU environment (venv)"
mkdir -p "$HOME/envs"
if [ ! -d "$HOME/envs/fullstack" ]; then
  python -m venv "$HOME/envs/fullstack"
fi
source "$HOME/envs/fullstack/bin/activate"
pip install --upgrade pip wheel setuptools

echo "==> Install scientific + DSP stack"
pip install numpy scipy pandas numba sympy h5py tqdm requests \
            matplotlib seaborn jupyterlab plotly opencv-python librosa soundfile pyaudio

echo "==> Install PyTorch 2.9 + TensorFlow 2.20 (GPU builds)"
if [ "$HAS_NVIDIA" -eq 1 ]; then
  pip install torch torchvision torchaudio tensorflow==2.20.0
else
  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
  pip install tensorflow-cpu==2.20.0
fi

echo "==> Verify GPU availability"
python - <<'PY'
import torch, tensorflow as tf
print("Torch:", torch.__version__, "CUDA:", torch.cuda.is_available())
print("TF:", tf.__version__, tf.config.list_physical_devices("GPU"))
PY

echo "==> Parallel math thread tuning"
NPROC=$(nproc || echo 8)
grep -q OMP_NUM_THREADS ~/.bashrc || cat >> ~/.bashrc <<EOF

# QSOL parallel tuning
export OMP_NUM_THREADS=$NPROC
export MKL_NUM_THREADS=$NPROC
EOF

echo "==> Optional creative stack"
need glances blender retroarch libretro-core-info goattracker

echo "==> Done."
echo "Notes:"
echo " • Re-login for realtime group + CUDA PATH"
echo " • Activate env:  source ~/envs/fullstack/bin/activate"
echo " • Launch Jupyter:  jupyter lab"
echo " • GPU verified via nvidia-smi and torch/tf GPU check."
