---

# 🖥️ Ubuntu Laptop Power Profiles

This repo contains two simple toggle scripts for **Ubuntu laptops** that let you switch between:

* **Office Mode** 🟢 → Max battery life (disable dGPU, cap CPU, lower refresh rate).
* **Gaming Mode** 🔴 → Full performance (enable dGPU, uncap CPU, max refresh rate).

These scripts are designed to be **generic**, so they should work on most Ubuntu laptops with Intel/AMD CPUs and optional NVIDIA GPUs.

---

## 📦 Features

* 🔋 **Office Mode**

  * Switch to integrated GPU (if available).
  * Enable [TLP](https://linrunner.de/tlp/) + powertop auto-tune for power saving.
  * Set CPU governor to `powersave` and cap max frequency (\~2.5GHz).
  * Lower display refresh rate to `90Hz` or `60Hz` if supported.

* 🎮 **Gaming Mode**

  * Switch to NVIDIA GPU (if available).
  * Disable TLP for maximum performance.
  * Set CPU governor to `performance` and restore max frequency.
  * Restore display refresh rate (120Hz/144Hz if available).

---

## ⚡ Installation

Clone the repo and make the scripts executable:

```bash
git clone https://github.com/mihirkulaa/Scripts.git
cd ubuntu-power-profiles
chmod +x office-mode.sh gaming-mode.sh
```

---

## 🚀 Usage

Switch to **office mode** (battery saving):

```bash
./office-mode.sh
```

Switch to **gaming mode** (full performance):

```bash
./gaming-mode.sh
```

---

## 🛠 Requirements

* Ubuntu (tested on 20.04 / 22.04 / 24.04).
* Packages (install if missing):

  ```bash
  sudo apt install tlp powertop linux-tools-common linux-tools-$(uname -r) cpufrequtils
  ```
* `prime-select` (for NVIDIA Optimus laptops). Will be skipped if unavailable.

---

## 🔄 Notes

* Scripts **skip gracefully** if a feature isn’t available on your system.
* Tested on Intel + NVIDIA hybrid laptops, but should also work with AMD + Intel setups.
* Refresh rate options depend on your display panel (not all panels support 90Hz).
* These changes are **reversible**: just toggle back with the opposite script.

---

## 📌 TODO

* [ ] Add **auto-switcher**: detect AC vs battery and switch profiles automatically.
* [ ] Add notifications for profile change.
* [ ] Extend support for AMDGPU power profiles.

---

## 📜 License

MIT License – free to use, modify, and share.

---
