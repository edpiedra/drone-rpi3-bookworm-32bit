#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_NAME=$(basename "$0")

SCRIPTS_DIR="/home/pi/drone-rpi3-bookworm-32bit/install/scripts"
source "$SCRIPTS_DIR/00_common.env"
source "$SCRIPTS_DIR/00_lib.sh"

if [ ! -d "$LOG_DIR"]; then 
    mkdir "$LOG_DIR" 
else 
    if [ -f "$LOG_FILE"]; then 
        rm -f "$LOG_FILE"
    fi
fi 

run_step() {
    local step="$1"
    log "running $step..."
    bash "$step"
}

if [[ "${1:-}" == "--continue-after-reboot" ]]; then
    log "post-reboot tasks starting..."

    for step in "$SCRIPTS_DIR"/1[0-9][0-9]_*.sh; do 
        run_step "$step"
    done 

    log "✅ Install complete. Logs saved to: $LOG_FILE"
    exit 0
elif [[ "${1:-}" == "--reinstall" ]]; then 
    log "reinstalling all packages..."

    if [ -d $LOG_DIR]; then 
        rm -rf "$LOG_DIR"
        mkdir "$LOG_DIR"
    fi 
fi 

for step in "$SCRIPTS_DIR"/[0-9][0-9]_*.sh; do 
    run_step "$step"
done 
