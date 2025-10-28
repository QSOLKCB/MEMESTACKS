# 🧠 MEMESTACKS  
*A collection of full QSOL Meme Stacks — fast, modular, and hardware-aware.*

---

## 🔍 Overview
**MEMESTACKS** is a modular setup framework for Arch Linux systems under the **QSOL** ecosystem.  
It provides two Bash scripts that collect hardware specs, verify your audio stack, and install a clean developer + podcaster environment.  
Built for real-world use — fast, transparent, and true to the motto: **“small is beautiful.”**

---

## ⚙️ Features
- **Hardware-aware bootstrap** — logs CPU, GPU, audio, and storage info into `/system_specs/`.
- **PipeWire Audio Stack** — installs and verifies PipeWire, WirePlumber, and all DSP/routing tools.
- **Developer Toolchain** — `clang`, `cmake`, `ninja`, `rust`, `go`, `python`, `npm` — ready out of the box.
- **Podcaster Toolkit** — OBS Studio, VokoscreenNG, Kdenlive, Easyeffects, FFmpeg, and routing via Helvum.
- **Miniforge + JupyterLab** — creates a lightweight Conda environment (`qsolimc`) for data, DSP, or AI workflows.

---

## 🧩 Requirements
- Arch Linux or derivative (Manjaro, EndeavourOS, Garuda)
- Active internet connection  
- `sudo` privileges  
- ≈ 2 GB free space for base packages  
- Optional: `yay` or `paru` for AUR extensions  

---

## 🧰 Installation

### 1️⃣ Clone the repository
```bash
git clone https://github.com/QSOLKCB/MEMESTACKS.git
cd MEMESTACKS
2️⃣ Run a dry run (safe simulation)
bash
Copy code
chmod +x setup_dryrun.sh
./setup_dryrun.sh
This logs system specs and shows which packages would be installed — no changes yet.

3️⃣ Run the full install
bash
Copy code
chmod +x setup_install.sh
./setup_install.sh
This installs all required packages, sets up the audio environment, and creates the qsolimc Conda environment.

✅ Verify Your Setup
After installation, confirm audio stack health:

bash
Copy code
systemctl --user status pipewire pipewire-pulse wireplumber
pactl list short sinks
pw-play /usr/share/sounds/alsa/Front_Center.wav
Use pavucontrol, helvum, or easyeffects to visualize and fine-tune routing.

🧠 Philosophy
“Efficiency before over-engineering.”

MEMESTACKS follows the QSOL principle: build software like good hardware — modular, optimized, and minimal.
Every package serves a purpose. Every script is transparent.
The result: fast bootstraps, low latency, and zero bloat.

📄 License
Released under the MIT License.
You’re free to use, modify, and redistribute — attribution appreciated.

🧭 Versioning
To tag and release:

bash
Copy code
git tag -a v1.0.0 -m "Initial MEMESTACKS release"
git push origin v1.0.0
🌐 QSOL Ecosystem
Part of the broader QSOLKCB project — exploring quantum-inspired, efficient, and creative software stacks.
For related repositories, visit github.com/QSOLKCB

Small is beautiful. Fast is holy.
