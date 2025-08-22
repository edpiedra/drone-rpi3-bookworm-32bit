#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

run_step() {
    local step="$1"
    log "running $step..."
    bash "$step"
}

if [[ "$1" == "--continue-after-reboot" ]]; then
    log "post-reboot tasks starting..."

    for step in "$SCRIPTS_DIR"/[1-9][0-9][0-9]_*.sh; do 
        run_step "$step"
    done 

    log "✅ Install complete. Logs saved to: $LOG_FILE"
    exit 0
fi 

for step in "$SCRIPTS_DIR"/[0-9][0-9]_*.sh; do 
    run_step "$step"
done 
