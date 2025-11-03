# 🧠 **MEMESTACKS**
*QSOL-grade system stacks — fast, modular, and unapologetically efficient.*

---

## 🔍 Overview
**MEMESTACKS** is a modular bootstrap framework for Arch-based systems within the **QSOL** ecosystem.  
It’s not another dotfile dump — it’s a living setup lab that detects your hardware, tunes your audio, and spins up a ready-to-create environment for developers, producers, and tinkerers alike.

> **Philosophy:** *small is beautiful, fast is holy.*

---

<details>
<summary><b>⚙️ Features</b></summary>

- 🧬 **Hardware-aware bootstrap** — logs CPU, GPU, storage, and audio specs into `/system_specs/`.
- 🎧 **PipeWire Audio Stack** — installs PipeWire, WirePlumber, and JACK bridge tools with realtime tuning.
- 💻 **Developer Toolchain** — `clang`, `cmake`, `ninja`, `rust`, `go`, `python`, and `npm` pre-loaded.
- 🎙️ **Podcaster / Creator Toolkit** — OBS Studio, VokoscreenNG, Kdenlive, Easyeffects, FFmpeg, Helvum routing.
- 📚 **Miniforge + JupyterLab** — creates a clean Conda environment (`qsolimc`) for data, DSP, or AI workflows.

Everything installed is traceable, modular, and rebuildable — no black boxes, no mystery daemons.  
Just **fast, predictable systems**.
</details>

---

<details>
<summary><b>🧩 Requirements</b></summary>

- Arch Linux or any derivative *(Manjaro, EndeavourOS, Garuda, etc.)*  
- Internet connection  
- `sudo` privileges  
- ~2 GB free disk space  
- Optional: `yay` or `paru` for AUR extras  
</details>

---

## 🚀 Installation

### 1️⃣ Clone the repo
```bash
git clone https://github.com/QSOLKCB/MEMESTACKS.git
cd MEMESTACKS
2️⃣ Dry-run (safe simulation)
bash
Copy code
chmod +x setup_dryrun.sh
./setup_dryrun.sh
Logs your hardware and lists all packages — no changes made.

3️⃣ Full install
bash
Copy code
chmod +x setup_install.sh
./setup_install.sh
Installs the full stack, configures audio, and builds the qsolimc Conda environment.

<details> <summary><b>✅ Post-Install Check</b></summary>
Run a quick sanity test after reboot:

bash
Copy code
systemctl --user status pipewire pipewire-pulse wireplumber
pactl list short sinks
pw-play /usr/share/sounds/alsa/Front_Center.wav
Use pavucontrol, helvum, or easyeffects to visualize and fine-tune routing.

</details>
🧠 Philosophy
“Efficiency before over-engineering.”

MEMESTACKS follows the QSOL credo:
build like hardware — minimal, transparent, and overclocked for creativity.

Every package earns its place. Every line has intent.
Result: fast boot, low latency, zero bloat.

📄 License
MIT License — free to use, modify, or remix.
Attribution appreciated. Forks encouraged.

<details> <summary><b>🧭 Versioning</b></summary>
bash
Copy code
git tag -a v1.0.0 -m "Initial MEMESTACKS release"
git push origin v1.0.0
</details>
🌐 QSOL Ecosystem
Part of the QSOLKCB project — exploring quantum-inspired systems for creative computation.
→ github.com/QSOLKCB

🕹️ Small is beautiful. Fast is holy. MEMESTACKS is both.
