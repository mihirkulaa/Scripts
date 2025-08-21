#!/bin/bash
# Office Mode - Generic Ubuntu Laptop
# Prioritizes battery life, disables dGPU (if possible), lowers CPU and refresh rate

echo "[*] Switching to Office Mode..."

# Use Intel/AMD integrated GPU only (if prime-select exists)
if command -v prime-select &> /dev/null; then
    sudo prime-select intel || sudo prime-select on-demand
    echo "[+] GPU set to integrated mode"
else
    echo "[-] prime-select not found, skipping GPU switch"
fi

# Enable TLP if installed
if command -v tlp &> /dev/null; then
    sudo systemctl enable tlp
    sudo systemctl start tlp
    echo "[+] TLP enabled"
else
    echo "[-] TLP not installed"
fi

# Powertop auto-tune if available
if command -v powertop &> /dev/null; then
    sudo powertop --auto-tune
    echo "[+] Powertop tuned"
fi

# CPU power saving (cap max frequency)
if command -v cpupower &> /dev/null; then
    sudo cpupower frequency-set -g powersave
    sudo cpupower frequency-set -u 2.5GHz
    echo "[+] CPU set to powersave governor, capped at 2.5GHz"
else
    echo "[-] cpupower not installed"
fi

# Lower refresh rate (try 60Hz or 90Hz if supported)
display=$(xrandr | grep " connected" | cut -d" " -f1 | head -n 1)
if [ -n "$display" ]; then
    if xrandr | grep -q "90.00"; then
        xrandr --output "$display" --rate 90
        echo "[+] Refresh rate set to 90Hz"
    elif xrandr | grep -q "60.00"; then
        xrandr --output "$display" --rate 60
        echo "[+] Refresh rate set to 60Hz"
    else
        echo "[-] Could not change refresh rate"
    fi
fi

echo "[*] Office mode activated. Battery life prioritized!"

