#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

INSTALL_FLAG="/tmp/install-after-reboot"
WRAPPER_SCRIPT="/usr/local/bin/install-wrapper.sh"

log "preparing for reboot..."
touch "$INSTALL_FLAG"

cat <<EOF | sudo tee "$WRAPPER_SCRIPT" > /dev/null
#!/bin/bash

# Only continue if the marker file exists
if [ -f "$INSTALL_FLAG" ]; then
    echo "[INFO] Resuming install after reboot..." >> $LOG_FILE
    bash $INSTALL_SCRIPT --continue-after-reboot >> $LOG_FILE 2>&1
    rm -f "$INSTALL_FLAG"
    rm -f "$WRAPPER_SCRIPT"
    crontab -l | grep -v "$WRAPPER_SCRIPT" | crontab -
fi
EOF

chmod +x "$WRAPPER_SCRIPT"
(crontab -l 2>/dev/null; echo "@reboot $WRAPPER_SCRIPT") | crontab -

