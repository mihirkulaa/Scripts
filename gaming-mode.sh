#!/bin/bash
# Gaming Mode - Generic Ubuntu Laptop
# Restores performance settings

echo "[*] Switching to Gaming Mode..."

# Use NVIDIA GPU if available
if command -v prime-select &> /dev/null; then
    sudo prime-select nvidia
    echo "[+] GPU set to NVIDIA mode"
else
    echo "[-] prime-select not found, skipping GPU switch"
fi

# Stop TLP (for full performance)
if command -v tlp &> /dev/null; then
    sudo systemctl stop tlp
    sudo systemctl disable tlp
    echo "[+] TLP disabled"
fi

# Restore CPU governor to performance and full frequency
if command -v cpupower &> /dev/null; then
    sudo cpupower frequency-set -g performance
    sudo cpupower frequency-set -u 4.5GHz
    echo "[+] CPU governor set to performance, max frequency restored"
fi

# Restore refresh rate to highest available (prefer 120Hz if present)
display=$(xrandr | grep " connected" | cut -d" " -f1 | head -n 1)
if [ -n "$display" ]; then
    if xrandr | grep -q "120.00"; then
        xrandr --output "$display" --rate 120
        echo "[+] Refresh rate set to 120Hz"
    elif xrandr | grep -q "144.00"; then
        xrandr --output "$display" --rate 144
        echo "[+] Refresh rate set to 144Hz"
    fi
fi

echo "[*] Gaming mode activated. Performance restored!"

