#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

require_root(){
  if [[ $EUID -ne 0 ]]; then
    echo "please run $SCRIPT_NAME with sudo." >&2
    exit 1
  fi
}

require_root

SERVICE_FILE="/etc/systemd/system/ardupilot.service"

log "setting up ArduPilot as a service..."
sudo tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=ArduPilot Navio2 Service
After=network.target

[Service]
ExecStart=$ARDUPILOT_BIN -A udp:$WIN_IP:14550
WorkingDirectory=$ARDUPILOT_DIR
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable ardupilot
sudo systemctl start ardupilot
