#!/usr/bin/env bash

clear
echo "🔥 LVM VPS PANEL INSTALLER 🔥"
sleep 1

# Update & install dependencies
echo "[+] Installing dependencies..."
apt update -y
apt install -y git unzip python3 python3-pip sqlite3

# Clone repo
echo "[+] Cloning repository..."
rm -rf /root/lvm-panel
git clone https://github.com/underdevanshxd/lvm-panel.git /root/lvm-panel

cd /root/lvm-panel || exit

# Unzip
echo "[+] Extracting files..."
if [ -f "lvm.zip" ]; then
    unzip -o lvm.zip
fi

# Install requirements
echo "[+] Installing Python packages..."
pip3 install -r requirements.txt

# Setup database
echo "[+] Setting up database..."
sqlite3 /root/lvm-panel/lvm.db <<EOF
CREATE TABLE IF NOT EXISTS license (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    license_key TEXT UNIQUE,
    is_activated INTEGER DEFAULT 0,
    activated_at TIMESTAMP,
    activated_by TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

# Done
echo "✅ INSTALLATION COMPLETE!"

# Run panel
echo "[+] Starting panel..."
python3 main.py
