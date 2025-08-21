#!/bin/bash
# Office Mode - Max Battery Life

echo "[*] Switching to Office Mode..."

# Use Intel iGPU only
if command -v prime-select &> /dev/null; then
    sudo prime-select intel
    echo "[+] Set GPU: Intel only"
fi

# Enable TLP for power saving
sudo systemctl enable tlp
sudo systemctl start tlp
echo "[+] TLP enabled"

# Run powertop auto-tune
if command -v powertop &> /dev/null; then
    sudo powertop --auto-tune
    echo "[+] Powertop tuned"
fi

# Install cpupower if missing
if ! command -v cpupower &> /dev/null; then
    sudo apt install -y linux-tools-common linux-tools-$(uname -r) cpufrequtils
fi

# Limit CPU to powersave mode and cap max freq (adjust to taste)
sudo cpupower frequency-set -g powersave
sudo cpupower frequency-set -u 2.5GHz
echo "[+] CPU governor set to powersave, capped at 2.5GHz"

# Disable keyboard backlight (Dell usually supports 0-3 levels)
if [ -f /sys/class/leds/dell::kbd_backlight/brightness ]; then
    echo 0 | sudo tee /sys/class/leds/dell::kbd_backlight/brightness > /dev/null
    echo "[+] Keyboard backlight disabled"
fi

# Lower screen refresh rate to 90Hz if supported
display=$(xrandr | grep " connected" | cut -d" " -f1 | head -n 1)
if xrandr | grep -q "90.00"; then
    xrandr --output "$display" --rate 90
    echo "[+] Refresh rate set to 90Hz"
else
    xrandr --output "$display" --rate 60
    echo "[+] 90Hz not supported, switched to 60Hz"
fi

echo "[*] Office mode activated. Battery life prioritized!"

