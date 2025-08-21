#!/bin/bash
# Gaming Mode - Restore Performance

echo "[*] Switching to Gaming Mode..."

# Use NVIDIA GPU
if command -v prime-select &> /dev/null; then
    sudo prime-select nvidia
    echo "[+] Set GPU: NVIDIA enabled"
fi

# Stop TLP for performance
sudo systemctl stop tlp
sudo systemctl disable tlp
echo "[+] TLP disabled"

# Restore CPU governor to performance, uncap frequency
sudo cpupower frequency-set -g performance
sudo cpupower frequency-set -u 4.4GHz   # adjust to your CPU's max
echo "[+] CPU governor set to performance, full speed"

# Enable keyboard backlight again (max brightness)
if [ -f /sys/class/leds/dell::kbd_backlight/brightness ]; then
    echo 3 | sudo tee /sys/class/leds/dell::kbd_backlight/brightness > /dev/null
    echo "[+] Keyboard backlight enabled"
fi

# Restore refresh rate to 120Hz
display=$(xrandr | grep " connected" | cut -d" " -f1 | head -n 1)
if xrandr | grep -q "120.00"; then
    xrandr --output "$display" --rate 120
    echo "[+] Refresh rate set to 120Hz"
fi

echo "[*] Gaming mode activated. Performance restored!"

